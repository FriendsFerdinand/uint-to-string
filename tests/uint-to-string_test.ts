
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let deployerWallet = accounts.get("deployer") as Account;
        let wallet1 = accounts.get("wallet_1") as Account;
        let wallet2 = accounts.get("wallet_2") as Account;

        for (let i = 0; i < 299; i++) {
            let block = chain.mineBlock([
                Tx.contractCall(
                    `uint-to-string`,
                    "uint-to-string",
                    [types.uint(i)],
                    deployerWallet.address
                ),
            ]);
            assertEquals(block.receipts[0].result, `u"${i}"`);
        }

    },
});
