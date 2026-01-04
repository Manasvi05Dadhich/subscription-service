# Subscription Smart Contract

This smart contract implements a **simple on-chain subscription system** using Ethereum and Solidity.

## What the Contract Does

* Users can **pay ETH to subscribe** to a service.
* Each user’s access is tracked using a **time-based expiry**.
* If a user subscribes again **before expiry**, their subscription is **extended**.
* If a user subscribes **after expiry**, a **new subscription period** starts.
* The contract automatically determines whether a user is subscribed by **comparing time**.

## Key Behavior

* Subscription status is based on:

  * `expiry > current blockchain time`
* No manual activation or flags are used.
* One function (`subscribe`) handles both **new subscriptions and renewals**.

## Roles

* **Owner**: Deploys the contract and can withdraw collected ETH.
* **Users**: Pay ETH to gain time-based access.

## ETH Handling

* ETH paid by users is stored in the contract.
* Only the owner can withdraw the accumulated ETH.

## Design Highlights

* Uses a mapping to store each user’s subscription expiry.
* Uses blockchain time (`block.timestamp`) for access control.
* Avoids redundant state like boolean flags.

## Summary

This contract provides a clean, minimal example of how to build a **time-based subscription system** on-chain, focusing on correctness, simplicity, and clear logic.
