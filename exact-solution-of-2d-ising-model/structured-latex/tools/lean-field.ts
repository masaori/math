/**
 * 欄 `lean`（対応する Lean の具体版の宣言）の、Lean の環境を読まずに決まる規則。`validate-content.ts` が使う。
 * 一対一の検査（`lean/scripts/text-and-concrete-one-to-one/compare.ts`）が読むのは定義・主張・定理だけなので、
 * ほかの種別に書いた欄は黙って無視される。そうならないよう、ここで落とす。同じ名前の重複も落とす。
 * 宣言が実在して具体版であることは、一対一の検査がビルド後の Lean の環境と突き合わせて確かめる。
 */
export const leanFieldIssueOf = (block: { kind: string; lean?: readonly string[] }): string | undefined => {
  if (block.lean === undefined) return undefined;
  if (block.kind !== "definition" && block.kind !== "claim" && block.kind !== "theorem") {
    return `欄 lean を書けるのは定義・主張・定理だけである（kind: ${block.kind}）`;
  }
  const seen = new Set<string>();
  for (const name of block.lean) {
    if (seen.has(name)) return `欄 lean に同じ宣言が二度ある: ${name}`;
    seen.add(name);
  }
  return undefined;
};
