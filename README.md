 Medibridge - Service Marketplace

Medibridge is a decentralized marketplace for services built on the Sui blockchain. This platform allows service providers to list their services, set prices, and receive payments in cryptocurrency. Users can pay for services and track the progress of their requests. The platform ensures secure transactions and service completion using smart contracts.

Features

- Service Creation: Service providers can list their services with a name, price, and status.
- Payment Processing: Users can make payments for services with balance checks and transaction logs.
- Service Completion: Service providers can mark a service as completed, signaling that the service is no longer available for purchase.
- Proceeds Claim: Providers can claim the proceeds from completed services after payment.

Technologies

- Sui Blockchain: For decentralized object storage and transaction management.
- Move Language: Smart contracts written in Move, a language for building secure and efficient blockchain programs.
- SUI Token: Used for payments in the marketplace.

Project Structure

Setup & Installation

1. Clone the Repository

    Clone the Medibridge repository to your local machine:

    ```bash
    git clone https://github.com/cactusjack-28/medibridge.git
    cd medibridge
    ```

2. Install Dependencies

    Ensure you have the Move language toolchain installed. Follow the official instructions from the [Move GitHub repository](https://github.com/diem/move) to install the required tools.

3. Deploy the Smart Contract

    Deploy the `medibridge.move` contract to the Sui blockchain. Refer to Sui documentation for specific instructions on deploying Move contracts.

4. Run Tests

    Run the provided test cases to ensure that everything is functioning correctly:

    ```bash
    move test
    ```
How It Works

- Service Creation: Service providers can create services by calling the `create_service` function. A service includes details like the service name, price, and balance.
  
- Making a Payment: Users can make a payment by calling `make_payment`, where their balance is verified, and the service's price is deducted from their balance.

- Completing a Service: Service providers can mark a service as completed using the `complete_service` function, making it unavailable for purchase.

- Claiming Proceeds: After completing a service, providers can claim their earnings using the `claim_proceeds` function.

Error Handling

- EServiceAlreadyCompleted: The service is already completed and cannot be processed.
- EInsufficientBalance: The user does not have enough balance to make the payment.
- EInvalidServiceID: The service ID provided is invalid.
- EServiceNotAvailable: The service is no longer available.

Contribution

We welcome contributions to Medibridge! If you'd like to contribute:

1. Fork this repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add feature'`)
4. Push to your branch (`git push origin feature-branch`)
5. Open a Pull Request

License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Medibridge is a decentralized service marketplace that aims to create a secure and transparent environment for users to buy and sell services using blockchain technology.
