#!/usr/bin/env node
/**
 * 英語版の実行時スキーマ（`../schema.ts` の `runtimeSchema` と `checkHabitation`）が、
 * **具体化しても効いていること**の実証テスト。
 *
 * 日本語版 `../structured-latex/tools/schema-runtime-test.ts` と重なるケースはあるが、
 * 検査対象が違う（英語版は住処の語彙を日本語版から import し、zod の enum を
 * `HABITAT_VALUES` から**組み立てて**いる。組み立てが壊れていれば住処の検査が丸ごと死ぬ）。
 * そこを実際に落として確かめるのがここの目的である。
 *
 * 使い方: node tools/schema-runtime-test.ts
 */

import { checkHabitation, runtimeSchema } from "../schema.ts";

type Case = { name: string; run: () => boolean };

const block = (extra: Record<string, unknown>): Record<string, unknown> => ({
  id: "t1",
  kind: "claim",
  labels: [],
  statement: [],
  habitat: "Lambda",
  ...extra,
});

const accepts = (value: unknown): boolean => runtimeSchema.validateBlock(value, "test").success;

const cases: Case[] = [
  {
    name: "habitat / realEscape / verification / lean は許可キーとして通る",
    run: () =>
      accepts(
        block({
          habitat: "mixed",
          realEscape: "the single limit in Chapter 3",
          verification: ["sagemath/check"],
          lean: ["Foo.bar"],
        }),
      ),
  },
  {
    name: "住処の綴り違い（Lamda）を拒む（HABITAT_VALUES からの enum 組み立てが効いていること）",
    run: () => !accepts(block({ habitat: "Lamda" })),
  },
  {
    name: "宣言していないキーを拒む（打ち間違いで中身が黙って捨てられるのを防ぐ）",
    run: () => !accepts(block({ realEscapes: "typo" })),
  },
  {
    name: "見出しに habitat があれば拒む（見出しは量を扱わない）",
    run: () =>
      !accepts({ id: "h1", kind: "heading", level: 1, labels: [], title: { text: "x" }, habitat: "Lambda" }),
  },
  {
    name: "本文ブロックに habitat が無ければ checkHabitation が拒む",
    run: () => checkHabitation({ id: "t1" }).length > 0,
  },
  {
    name: "可算な habitat に realEscape があれば checkHabitation が拒む",
    run: () => checkHabitation({ id: "t1", habitat: "Lambda", realEscape: "x" }).length > 0,
  },
  {
    name: "非可算な habitat に realEscape が無ければ checkHabitation が拒む",
    run: () => checkHabitation({ id: "t1", habitat: "R" }).length > 0,
  },
  {
    name: "可算な habitat で realEscape が無ければ通る（対照）",
    run: () => checkHabitation({ id: "t1", habitat: "Lambda" }).length === 0,
  },
  // --- 引用ノード（英語版で新たに使う語彙）-------------------------------------
  {
    name: "引用ノードを受け入れる（keys のみ / note つきの両方）",
    run: () =>
      accepts(
        block({
          statement: [
            { type: "cite", keys: ["Monsky1981"] },
            { type: "cite", keys: ["Monsky1981", "CuocoMonsky1981"], note: "Theorem 5.6" },
          ],
        }),
      ),
  },
  {
    name: "引用キーが空配列なら拒む（引用先の無い引用は意味を持たない）",
    run: () => !accepts(block({ statement: [{ type: "cite", keys: [] }] })),
  },
  {
    name: "引用ノードのキー名の打ち間違い（key）を拒む",
    run: () => !accepts(block({ statement: [{ type: "cite", key: ["Monsky1981"] }] })),
  },
];

let failed = 0;
for (const testCase of cases) {
  if (testCase.run()) {
    console.log(`✓ ${testCase.name}`);
  } else {
    failed += 1;
    console.error(`✗ ${testCase.name}`);
  }
}

if (failed > 0) {
  console.error(`\n${failed} 件の実行時検証テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\n実行時検証テスト ${cases.length} 件すべて期待どおり`);
