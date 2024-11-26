module medibridge::marketplace {

    use sui::balance::{Self, Balance};
    use sui::event::{Self};
    use sui::sui::SUI;


    const EServiceAlreadyCompleted: u64 = 0;
    const EInsufficientBalance: u64 = 1;
    const EInvalidServiceID: u64 = 2;
    const EServiceNotAvailable: u64 = 3;

    public struct ServiceCreated has copy, drop {
        service_id: ID,
        service_name: vector<u8>,
        price: u64,
    }

    public struct PaymentMade has copy, drop {
        service_id: ID,
        payer: address,
        amount: u64,
    }

    public struct ServiceCompleted has copy, drop {
        service_id: ID,
    }

    
    public struct Service has key {
        id: UID,
        service_name: vector<u8>, 
        provider: address,        
        price: u64,               
        active: bool,             
        balance: Balance<SUI>,    
    }

    public struct ProviderCap has key, store {
        id: UID,
        service_id: ID,
    }

    public fun get_service_price(service: &Service): u64 {
        service.price
    }

    public fun create_service(
        service_name: vector<u8>,
        price: u64,
        ctx: &mut TxContext,
    ): ProviderCap {
        let service = Service {
            id: object::new(ctx),
            service_name,
            provider: tx_context::sender(ctx),
            price,
            active: true,
            balance: balance::zero(),
        };

        let provider_cap = ProviderCap {
            id: object::new(ctx),
            service_id: object::uid_to_inner(&service.id),
        };

        event::emit(ServiceCreated {
            service_id: object::uid_to_inner(&service.id),
            service_name: service.service_name,
            price,
        });

        transfer::share_object(service);
        provider_cap
    }

    public fun make_payment(
        service: &mut Service,
        mut payer_balance: Balance<SUI>,
        ctx: &mut TxContext,
    ): Balance<SUI> {
        assert!(service.active, EServiceNotAvailable);
        assert!(payer_balance.value() >= service.price, EInsufficientBalance);

        let payment = balance::split(&mut payer_balance, service.price);
        balance::join(&mut service.balance, payment);

        event::emit(PaymentMade {
            service_id: object::uid_to_inner(&service.id),
            payer: ctx.sender(),
            amount: service.price,
        });

        payer_balance
    }

    public fun complete_service(
        service: &mut Service,
        provider_cap: &ProviderCap,
    ) {
        assert!(object::uid_to_inner(&service.id) == provider_cap.service_id, EInvalidServiceID);
        assert!(service.active, EServiceAlreadyCompleted);

        service.active = false;

        event::emit(ServiceCompleted {
            service_id: object::uid_to_inner(&service.id),
        });
    }

    public fun claim_proceeds(
        service: Service,
        provider_cap: ProviderCap,
    ): Balance<SUI> {
        assert!(object::uid_to_inner(&service.id) == provider_cap.service_id, EInvalidServiceID);
        assert!(!service.active, EServiceNotAvailable);

        let Service { id, service_name: _, provider: _, price: _, active: _, balance } = service;

        object::delete(id);

        let ProviderCap { id, service_id: _ } = provider_cap;
        object::delete(id);

        balance
    }
}
