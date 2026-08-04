/**
 * **検査 Λ が実際に落ちることの実証**。
 *
 * 再現データは、**現に起きた 3 件そのもの**である（cycle 29 step 4 が見つけ、cycle 31 step 2 で改名した）。
 * すなわち、例外直線の $\lambda$ の和を $\Lambda:=\sum\lambda$ と置いた形、
 * $\Lambda(r):=\min_j(e_j+j\ell^r)$ と引数を付けた形、
 * $\Lambda_k:=\min_m v_\ell(A^{[k]}_m)$ と添字を付けた形の 3 つを合成データで通し、3 つとも赤くなることを見る。
 *
 * 併せて、**改名後に残った正しい用例が違反にならないこと**も確かめる
 * （誤検出する検査は使われなくなるため）。
 *
 * 実行: `npm run test:lambda-symbol`
 */

import { auditLambdaSymbol, type LambdaAllowance, type LambdaUseSite } from "./lambda-symbol-model.ts";

const allowances: readonly LambdaAllowance[] = [
  { block: "def_ladder", reason: "対数順序群を定義するブロック", defines: true },
  { block: "remark_asymmetry", reason: "対数順序群に言及する注記" },
];

const site = (blockId: string, tex: string): LambdaUseSite => ({
  blockId,
  locale: "ja",
  file: "fixture.ts",
  tex,
});

const run = (sites: readonly LambdaUseSite[], allow = allowances) =>
  auditLambdaSymbol({ sites, allowances: allow });

const cases: readonly {
  readonly name: string;
  readonly sites: readonly LambdaUseSite[];
  readonly allowances?: readonly LambdaAllowance[];
  /** 違反に含まれていてほしい字面（`undefined` なら違反 0 件を期待する）。 */
  readonly expect?: string;
}[] = [
  // --- 現に起きた 3 件（改名前の形）------------------------------------------
  {
    name: "実際に起きた形 1: 例外直線の λ の和を \\Lambda:= と置いた（命題 G′ の章）",
    sites: [site("remark_asymmetry", String.raw`\Lambda:=\sum_{\text{例外直線}}\lambda`)],
    expect: "[記号を定義し直している]",
  },
  {
    name: "実際に起きた形 2: \\Lambda(r) と引数を付けた（θ の p 進の章）",
    sites: [site("remark_asymmetry", String.raw`\Lambda(r):=\min_{j\ge0}\bigl(e_j+j\,\ell^{r}\bigr)`)],
    expect: "[記号に飾りが付いている]",
  },
  {
    name: "実際に起きた形 3: \\Lambda_k と添字を付けた（一般閉形式の章）",
    sites: [site("remark_asymmetry", String.raw`\Lambda_k:=\min_m v_\ell(A^{[k]}_m)`)],
    expect: "[記号に飾りが付いている]",
  },
  // --- 同型（肩・新しいブロック）----------------------------------------------
  {
    name: "肩に付けた形も落ちる",
    sites: [site("remark_asymmetry", String.raw`\Lambda^{(2)}`)],
    expect: "[記号に飾りが付いている]",
  },
  {
    name: "台帳に無いブロックが使い始めたら落ちる",
    sites: [site("brand_new_block", String.raw`\Lambda`)],
    expect: "[台帳に無いブロックが記号を使っている]",
  },
  {
    name: "台帳にあるのに 1 度も使わなくなったら落ちる（登録が古い）",
    sites: [site("def_ladder", String.raw`\Lambda=\bigoplus_p\mathbb{Z}\,\ell_p`)],
    expect: "[登録が古い]",
  },
  // --- 誤検出しないこと --------------------------------------------------------
  {
    name: "定義してよいブロックが \\Lambda:= を書くのは通る",
    sites: [
      site("def_ladder", String.raw`\Lambda:=\bigoplus_p\mathbb{Z}\,\ell_p`),
      site("remark_asymmetry", String.raw`\Lambda`),
    ],
  },
  {
    name: "改名後に残った正しい用例（裸で使う・等号で書く・包含で書く）は通る",
    sites: [
      site("def_ladder", String.raw`\Lambda=\bigoplus_{p}\mathbb{Z}\,\ell_p`),
      site("remark_asymmetry", String.raw`\log q:=\sum_p e_p\,\ell_p\in\Lambda`),
      site("remark_asymmetry", String.raw`\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}`),
    ],
  },
  {
    name: "改名後の記号（\\lambda_{\\mathrm{exc}} / \\mathcal{E}(r) / \\mathcal{V}_k）は対象外なので通る",
    sites: [
      site("def_ladder", String.raw`\Lambda`),
      site("remark_asymmetry", String.raw`\lambda_{\mathrm{exc}}=\lambda_1`),
      site("remark_asymmetry", String.raw`\mathcal{E}(r)=e_m+m\,\ell^{r}`),
      site("remark_asymmetry", String.raw`\mathcal{V}_k\in\mathbb{Z}`),
    ],
  },
];

let failed = 0;
for (const testCase of cases) {
  const { violations } = run(testCase.sites, testCase.allowances ?? allowances);
  const ok =
    testCase.expect === undefined
      ? violations.length === 0
      : violations.some((violation) => violation.includes(testCase.expect!));
  if (!ok) {
    failed += 1;
    console.log(`NG  ${testCase.name}`);
    console.log(`    期待: ${testCase.expect ?? "違反 0 件"}`);
    console.log(`    実際: ${violations.length === 0 ? "違反 0 件" : violations.join(" / ")}`);
  } else {
    console.log(`OK  ${testCase.name}`);
  }
}

if (failed > 0) {
  console.log(`NG: ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(`OK: ${cases.length} 件すべて期待どおり。`);
