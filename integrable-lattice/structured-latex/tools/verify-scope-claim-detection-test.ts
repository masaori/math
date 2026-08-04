/**
 * **「射程の主張」の裏取りが、実際に落ちることの実証**。
 *
 * 検出できるだけでは足りず、**現に台帳が取っている形が違反にならないこと**も要る
 * （誤検出する検査は使われなくなる）。両方向を合成データで通す。
 *
 * 再現データは**現に台帳にある 3 つの形そのもの**である
 * （体を要求するトレース双対／多変数を使わない Mahler 測度／整除と結ばれない単因子）。
 *
 * 実行: `npm run test:scope-claim`
 */

import { auditScopeClaims, type ScopeClaim } from "./scope-claim-support.ts";

/** 現に mathlib が取っている形（仮定は宣言行ではなく `variable` 行にある）。 */
const traceDualSource = [
  "section Basis",
  "variable [FiniteDimensional K L] [Algebra.IsSeparable K L] [Finite ι] [DecidableEq ι]",
  "variable (b : Basis ι K L)",
  "",
  "noncomputable def Module.Basis.traceDual :",
  "    Basis ι K L :=",
  "  (traceForm K L).dualBasis (traceForm_nondegenerate K L) b",
].join("\n");

const mahlerSource = ["import Mathlib.Analysis.SpecialFunctions.Log.Basic", "def mahlerMeasure (p : ℂ[X]) : ℝ := 0"].join("\n");

const smithLines = [
  "noncomputable def Ideal.smithCoeffs (b : Basis ι R S) (I : Ideal S) (hI : I ≠ ⊥) : ι → R :=",
  "theorem Ideal.smithCoeffs_ne_zero (b : Basis ι R S) (I : Ideal S) (hI : I ≠ ⊥) (i) :",
];

const 健全な仮定: ScopeClaim = {
  entry: "fixture-trace-dual",
  kind: "宣言が仮定を要求する",
  file: "Trace.lean",
  declaration: "Module.Basis.traceDual",
  requires: ["[Algebra.IsSeparable K L]"],
  why: "体の上にしかない",
};
const 健全な不使用: ScopeClaim = {
  entry: "fixture-mahler",
  kind: "在るが概念を使っていない",
  file: "Mahler.lean",
  absentToken: "MvPolynomial",
  why: "多変数が無い",
};
const 健全な無関係: ScopeClaim = {
  entry: "fixture-smith",
  kind: "在るが関係が無い",
  presentToken: "smithCoeffs",
  unrelatedToken: "∣",
  why: "整除の鎖が無い",
};

const files = new Map([
  ["Trace.lean", traceDualSource],
  ["Mahler.lean", mahlerSource],
]);

const run = (claims: readonly ScopeClaim[], opts?: { readonly noMathlib?: boolean; readonly lines?: readonly string[] }) =>
  auditScopeClaims({
    claims,
    readMathlibFile: (path) => (opts?.noMathlib ? undefined : files.get(path)),
    grepMathlib: opts?.noMathlib ? undefined : (token) => (opts?.lines ?? smithLines).filter((l) => l.includes(token)),
  });

const cases: readonly {
  readonly name: string;
  readonly claims: readonly ScopeClaim[];
  readonly opts?: { readonly noMathlib?: boolean; readonly lines?: readonly string[] };
  /** 期待する状態。`違反` なら違反 1 件以上を期待する。 */
  readonly expect: "裏が取れた" | "違反" | "確かめられない";
}[] = [
  // 現に台帳が取っている 3 つの形は、いずれも通る。
  { name: "宣言が仮定を要求する（variable 行に仮定がある形）", claims: [健全な仮定], expect: "裏が取れた" },
  { name: "在るが概念を使っていない（1 変数だけの Mahler 測度）", claims: [健全な不使用], expect: "裏が取れた" },
  { name: "在るが関係が無い（整除と結ばれない単因子）", claims: [健全な無関係], expect: "裏が取れた" },
  // 反証されたら赤くする。
  {
    name: "要求すると書いた仮定が、実際には要求されていない",
    claims: [{ ...健全な仮定, requires: ["[CommRing R]"] }],
    expect: "違反",
  },
  {
    name: "在ると書いた宣言が、そのファイルに無い",
    claims: [{ ...健全な仮定, declaration: "Module.Basis.doesNotExist" }],
    expect: "違反",
  },
  {
    name: "使っていないと書いた語が、実際には使われている",
    claims: [{ ...健全な不使用, absentToken: "mahlerMeasure" }],
    expect: "違反",
  },
  {
    name: "無いと書いた組合せが、実際には同じ行に在る",
    claims: [健全な無関係],
    opts: { lines: ["theorem smithCoeffs_dvd : smithCoeffs i ∣ smithCoeffs j := by sorry"] },
    expect: "違反",
  },
  {
    name: "在ることを前提にした語が、mathlib に 1 件も無い",
    claims: [健全な無関係],
    opts: { lines: ["theorem unrelated : True := trivial"] },
    expect: "違反",
  },
  // mathlib が無いときは違反にしない（npm run check は mathlib 不在でも通る前提である）。
  {
    name: "mathlib が無いときは違反にせず「確かめられない」に数える",
    claims: [健全な仮定, 健全な不使用, 健全な無関係],
    opts: { noMathlib: true },
    expect: "確かめられない",
  },
];

let failed = 0;
for (const testCase of cases) {
  const audit = run(testCase.claims, testCase.opts);
  const ok =
    testCase.expect === "違反"
      ? audit.violations.length > 0
      : testCase.expect === "確かめられない"
        ? audit.violations.length === 0 && audit.counts.確かめられない === testCase.claims.length
        : audit.violations.length === 0 && audit.counts.裏が取れた === testCase.claims.length;
  if (!ok) {
    failed += 1;
    console.log(`NG  ${testCase.name}`);
    console.log(`    期待: ${testCase.expect}`);
    console.log(`    実際: ${JSON.stringify(audit.counts)} / 違反 ${audit.violations.length} 件`);
    for (const violation of audit.violations) console.log(`      ${violation}`);
  } else {
    console.log(`OK  ${testCase.name}`);
  }
}

if (failed > 0) {
  console.log(`NG: ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(`OK: ${cases.length} 件すべて期待どおり。`);
