/**
 * **散文の名指しと残りの勘定の突き合わせ**（cycle 45 step 1 で新設。検査 J）。
 *
 * ## なぜこれが要るか
 *
 * cycle 44 step 1 で、**台帳の散文が cycle 29 以来「入っていない」と名指ししていた事柄が、
 * 残り項目としては 1 度も数えられていなかった**ことが分かった。
 * 検査 F が見ているのは「残り項目が散文にそのまま在ること」であって、
 * **その逆向き——散文が未形式化と言っている事柄が残り項目に在ること——は誰も見ていなかった。**
 * したがって、名指しだけして数えない書き方がそのまま通り、
 * **段を取り切っても件数も段数も動かない**という形が繰り返し起きていた。
 *
 * この検査はその逆向きを見る。
 *
 * ## 機械が確かめること
 *
 * 1. **散文の中で未形式化を名指している文を、機械が全数で拾う**（下の目印の語）。
 * 2. 拾った文が **残り項目の文字列を含む**か、**残っている部の記号を含む**なら、それは数に入っている。
 * 3. どちらでもない文は、**台帳に処分を宣言しなければ違反**にする。
 *    処分は 3 種——`残り`（数に入っている先を書く）／`済み`（後の段で埋めた宣言を書く）／
 *    `対象外`（未形式化の名指しではない理由を書く）。
 * 4. 宣言した文が散文にそのまま在ること（改稿で浮いた宣言を腐りとして検出する）。
 * 5. **残り項目の文字列が、その欄の散文にそのまま在ること。**
 *    検査 F の同じ要求は部を持たない欄にしか当たっていなかったので、ここでは全欄に当てる。
 *
 * ## 限界（正直に書く）
 *
 * - **目印の語に当たらない言い方で名指されたら拾えない。** 語の一覧は実測で作ったものであって、
 *   原理から出たものではない（cycle 45 step 1 の実測で、`書いておらず` という言い方が
 *   1 件だけ他と違う形で出た。それを見て語を足した）。
 * - **処分の判断は人の読みである。** 機械が見るのは、判断が書かれていることと、
 *   書かれた判断が腐っていないことだけである。`済み` と書いたものが本当に済んでいるかは見ていない。
 * - **拾った文が数に入っていることを見るだけで、数が実態を尽くしているかは見ていない**
 *   （検査 D・F の限界と同じ）。
 */

/** 未形式化の名指しを拾う目印の語（cycle 45 step 1 の実測で作った）。 */
export const NAMING_MARKERS: readonly string[] = [
  "未形式化",
  "形式化していない",
  "形式化されていない",
  "入っていない",
  "入れていない",
  "書いていない",
  "書いておらず",
  "書けていない",
  "型にしていない",
  "覆っていない",
  "触れていな",
  "できていない",
  "受け取っている",
  "受け取ったまま",
  "仮定として型に出",
  "挙げている",
  "未設計",
];

export type NamingKind = "残り" | "済み" | "対象外";

export type NamingDisposition = {
  /** 検査 F の台帳の `block`。 */
  readonly block: string;
  /** 散文の中のその文（そのまま在ることを毎回確かめる）。 */
  readonly sentence: string;
  readonly kind: NamingKind;
  /** `残り` なら数に入っている先、`済み` なら埋めた宣言、`対象外` ならその理由。 */
  readonly why: string;
};

/** 文へ割る（句点で切る）。 */
export function splitSentences(text: string): string[] {
  return text
    .split(/(?<=。)/)
    .map((x) => x.trim())
    .filter((x) => x.length > 0);
}

export function auditNamingCoverage(input: {
  readonly entries: readonly {
    readonly block: string;
    readonly prose: string;
    readonly remainingItems?: readonly string[];
    readonly openParts?: readonly string[];
  }[];
  readonly dispositions: readonly NamingDisposition[];
}): {
  violations: string[];
  named: number;
  autoCovered: number;
  dispositioned: number;
  byKind: Record<NamingKind, number>;
} {
  const violations: string[] = [];
  let named = 0;
  let autoCovered = 0;
  let dispositioned = 0;
  const byKind: Record<NamingKind, number> = { 残り: 0, 済み: 0, 対象外: 0 };
  const used = new Set<NamingDisposition>();
  const blocks = new Set(input.entries.map((e) => e.block));

  for (const entry of input.entries) {
    // 5. 残り項目が散文にそのまま在ること（全欄に当てる）。
    for (const item of entry.remainingItems ?? []) {
      if (!entry.prose.includes(item)) {
        violations.push(
          `[残り項目が散文に無い] ${entry.block} — 「${item}」が欄の散文に無い`,
        );
      }
    }
    for (const sentence of splitSentences(entry.prose)) {
      if (!NAMING_MARKERS.some((m) => sentence.includes(m))) continue;
      named += 1;
      const byItem = (entry.remainingItems ?? []).some((i) => sentence.includes(i));
      const byPart = (entry.openParts ?? []).some((p) => sentence.includes(p));
      if (byItem || byPart) {
        autoCovered += 1;
        continue;
      }
      const found = input.dispositions.filter(
        (d) => d.block === entry.block && sentence.includes(d.sentence),
      );
      if (found.length === 0) {
        violations.push(
          `[名指しの処分が無い] ${entry.block} — 「${sentence.slice(0, 60)}…」が` +
            "未形式化を名指しているのに、残り項目にも残っている部にも当たらず、処分の宣言も無い" +
            "（`ledger-naming-model.ts` に 残り／済み／対象外 のどれかを理由つきで書くこと）",
        );
        continue;
      }
      dispositioned += 1;
      for (const d of found) {
        used.add(d);
        byKind[d.kind] += 1;
      }
      if (found.some((d) => d.why.trim().length === 0)) {
        violations.push(`[処分に理由が無い] ${entry.block} — 「${sentence.slice(0, 40)}…」`);
      }
    }
  }

  for (const d of input.dispositions) {
    if (!blocks.has(d.block)) {
      violations.push(`[台帳に無い欄] ${d.block} — 検査 F の台帳に無い`);
      continue;
    }
    if (!used.has(d)) {
      violations.push(
        `[処分が腐っている] ${d.block} — 宣言した文「${d.sentence.slice(0, 40)}…」が` +
          "いま散文の名指しに当たらない（改稿で浮いたか、数に入って処分が要らなくなった）",
      );
    }
  }

  return { violations, named, autoCovered, dispositioned, byKind };
}

/**
 * **処分の台帳**（cycle 45 step 1 の実測。全 34 件）。
 *
 * 内訳は 残り 13・済み 16・対象外 5 である。
 * **`残り` と判定したものは、この数え直しで残り項目・部として数え直した先を指している。**
 */
export const NAMING_DISPOSITIONS: readonly NamingDisposition[] = [
  {
    block: "paper_043b_theorem_trace_bound",
    sentence: "ただし本文の「$\\rho\\bmod p$ が分離的かつ $p\\nmid m_\\lambda$」への翻訳は入っていない）。",
    kind: "残り",
    why: "残り項目「本文の $w^*=0$ が…同値であることの翻訳である」がこの事柄そのものである（cycle 44 step 1 で数え直して項目へ入れた）",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    sentence: "**cycle 19 から「整数行列の Smith 標準形が mathlib に無い」を理由に仮定として型に出したままだった段だが、行列の単因子は要らなかった**——$G$ の像について `IsPLevel`（$p$ の外での包含の最小レベル）だけを使えばよく、それは `isLeast_isPLevel` が部分加群の適合基底から与えている。",
    kind: "済み",
    why: "cycle 37 step 3 で書いた（`TracePeriodWStarLift.dvd_of_mulVec_dvd_of_isPLevel`）。同じ段落の「したがってこの主張の残りは 1 つである」がその結論である",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    sentence: "上界の証明で $w^*$ が果たす役割は仮定として型に出してある。",
    kind: "済み",
    why: "同上（`TracePeriodWStarLift.dvd_of_mulVec_dvd_of_isPLevel`）。上界の組み立てで $w^*$ が果たす役割はこの段が与える",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    sentence: "**`WStarMuGram.lean` が持っているのは $\\chi'/h\\equiv a_i\\,\\rho'\\pmod{f_i}$ という多項式の合同までで、射影を経由した像の等式は書いていない**（2026-08-05 に同ファイルを直読して確かめた。",
    kind: "済み",
    why: "cycle 44 step 1 で書いた（`PropCMuComponent.algHomOfDvd_mu_eq_multiplicity`）",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    sentence: "**これは本欄の散文が cycle 29 以来「入っていない」と名指ししていたのに、残り項目としては 1 度も数えられていなかった事柄である**（`wStarOfCoeffs_eq_zero_iff` が与えるのは「適合基底の係数がどれも $p$ で割れない」という別の判定である。",
    kind: "対象外",
    why: "この文は事柄を名指ししているのではなく、名指しと勘定が食い違っていたという経緯を書いている（指している事柄は残り項目そのもの）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "** (b)(c) は `PowerBasis K L`（$L$ は体）を使っており $\\rho$ が既約な場合しか覆っていない。",
    kind: "済み",
    why: "cycle 36 step 1 で可換環の上へ書き直した（`EulerDualBasisCommRing` の 段 2–5）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "(2) **$\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)$ が可約な場合に無い**——`det_weightedGram` は `PowerBasis K L`（$L$ は体）で書かれており、本文の 2 つめの等式は既約な場合しか覆っていない（2026-08-05 実測、宣言行で直読）。",
    kind: "済み",
    why: "cycle 37 step 1 で埋めた（`EulerDualBasis.det_weightedGram`。判別式を経由しなければ体は要らない）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "**未形式化である。",
    kind: "済み",
    why: "直前の文の続きで、同じ事柄を指す（`EulerDualBasis.det_weightedGram`）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "どちらも仮定として受け取っている。",
    kind: "済み",
    why: "cycle 37 step 1（`WStarPowerBasisInstance.isPowerBasisOf_adjoinRoot`）と cycle 38 step 1（`WStarSquarefreeNonzero`）で埋めた",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "これは未形式化であり、そう書く。",
    kind: "済み",
    why: "cycle 38 step 1 で書いた（`WStarSquarefreeNonzero.det_weightedGram_ne_zero_of_squarefree`）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "** 本 step が書いたのは「$\\rho$ が無平方かつ $\\mu$ が零因子でないならば $\\det G\\neq0$」という**含意**であって、その 2 つの仮定は受け取っている。",
    kind: "済み",
    why: "cycle 39 step 3 で 2 つとも構成した（`WStarRadicalMultiplicity.squarefree_rad` / `multWeight_mem_nonZeroDivisors`）",
  },
  {
    block: "paper_046_theorem_wstar_different",
    sentence: "また段 1 が使う $\\mathbb{Q}[x]$ 側の無平方性（$\\mathbb{Z}[x]$ 側からの降下＝Gauss）は仮定として受け取っている。",
    kind: "済み",
    why: "cycle 46 step 1 で配線した（`WStarGaussDescent.squarefree_map`。素材は cycle 38 step 1 の `squarefree_map_of_monic` に在った）",
  },
  {
    // cycle 46 step 1: 検査 J を 完了 の欄へも当てたときに出てきた 1 件。
    block: "paper_106_theorem_drop_assumption",
    sentence: "** (4) $\\bar{\\tilde E}$ の分解 $(1.2)$ そのもの（cycle 20 の定理 W1・W4）は補題 Q1′ の主張ではないので、仮定として型に出してある。",
    kind: "対象外",
    why: "この欄では数えない。分解 $(1.2)$ の中身は 2 つに分かれ、定理 W4 は 命題 K の欄が残り項目「定理 W4 の主張そのもの」として数えており、定理 W1（1 変数の $\\ell$ 進 Weierstrass 準備定理）は mathlib に在る（`PowerSeries.exists_isWeierstrassFactorization`。外部定理の台帳が Monsky の欄で名指ししている）。二重に数えないため",
  },
  {
    block: "paper_052_theorem_l0_computable",
    sentence: "mathlib に `Nat.Partrec` / `Turing` は在るが、「係数を計算する手続きで与えられた $f$」という入力の与え方を型にする設計をこちらが持っていない（mathlib の欠落ではなく、こちらの未設計である）。",
    kind: "残り",
    why: "部 (F2) の残りそのものである（停止問題への帰着の入力の与え方が未設計）",
  },
  {
    block: "paper_053_theorem_lower_order",
    sentence: "**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。",
    kind: "済み",
    why: "cycle 39 step 2 で書いた（`CharacterDecompositionTwoVariable`）。同じ段落が「この主張の残りは指標分解ではなくなった」と書いている",
  },
  {
    block: "paper_053_theorem_lower_order",
    sentence: "**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
    kind: "対象外",
    why: "散文自身が「本主張の残りではなく道具の一般性の話である」と書いている（他の欄でも同じ）",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    sentence: "Newton 多面体・$\\pi$ 進評価・例外直線の決定は未形式化。",
    kind: "残り",
    why: "部 (G′1)(G′2)(G′3) の残りそのものである",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    sentence: "円分体も分岐も mathlib に在る）を挙げている。",
    kind: "残り",
    why: "残り項目「定理 X の付値計算そのもの」がこの事柄である（文が 2 つに割れているので、名指しは前の文にある）",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    sentence: "どちらも未形式化である。",
    kind: "残り",
    why: "部 (G′1)(G′2) の残りそのものである",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    sentence: "**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。",
    kind: "済み",
    why: "cycle 39 step 2 で書いた（`CharacterDecompositionTwoVariable`）",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    sentence: "**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
    kind: "対象外",
    why: "散文自身が「本主張の残りではなく道具の一般性の話である」と書いている",
  },
  {
    block: "paper_056_theorem_ell2_family",
    sentence: "4 通りの閉形式の導出そのものは未形式化。",
    kind: "残り",
    why: "部 (G″2)(G″3)(G″4)(G″5) の残りそのものである",
  },
  {
    block: "paper_056_theorem_ell2_family",
    sentence: "**cycle 34 step 3 の照合で、`EllTwoClosedForm.lean` が挙げている matrix-tree 定理も足す**（$\\kappa_n$ の独立計算に要る。",
    kind: "済み",
    why: "cycle 37 step 2（`KirchhoffCounting.det_mul_transpose_eq_card_spanning`）と cycle 39 step 2（`CharacterDecompositionTwoVariable`）で閉じた",
  },
  {
    block: "paper_056_theorem_ell2_family",
    sentence: "いずれも未形式化である（形式化してあるのは (G″1) の付値の議論だけである）。",
    kind: "残り",
    why: "部 (G″2)(G″3)(G″4)(G″5) の残りそのものである",
  },
  {
    block: "paper_056_theorem_ell2_family",
    sentence: "**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。",
    kind: "済み",
    why: "cycle 39 step 2 で書いた（`CharacterDecompositionTwoVariable`）",
  },
  {
    block: "paper_056_theorem_ell2_family",
    sentence: "**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
    kind: "対象外",
    why: "散文自身が「本主張の残りではなく道具の一般性の話である」と書いている",
  },
  {
    block: "paper_062_theorem_T",
    sentence: "**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。",
    kind: "済み",
    why: "cycle 39 step 2 で書いた（`CharacterDecompositionTwoVariable`）。同じ段落が「この主張の残りは指標分解ではない」と書いている",
  },
  {
    block: "paper_062_theorem_T",
    sentence: "そう書く**——本ファイルは「Hensel 的な局所環で剰余体が原始 $L$ 乗根を持つ」ことを仮定として型に出しており、$\\mathbb{Q}(\\zeta_L)$ の 2 の上の素点での完備化がそれを満たすことは書いていない。",
    kind: "残り",
    why: "残り項目「完備化がこの舞台の形をしていること」がこの事柄そのものである",
  },
  {
    block: "paper_062_theorem_T",
    sentence: "そう書く**——残っているのは、その舞台の剰余体が原始 $L$ 乗根を持つことの同定である（本文が言っているのは $\\mathbb{Q}(\\zeta_L)$ の 2 の上での完備化についてであり、`PropTHenselLift.lean` の段 1・段 2 は根の側を仮定として受け取ったままである）。",
    kind: "済み",
    why: "cycle 44 step 2 で書いた（`PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo`）",
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    sentence: "未形式化である。",
    kind: "残り",
    why: "部 (K7) の残りそのものである（名指しは前の文にある）",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    sentence: "閉形式の導出そのものは未形式化。",
    kind: "残り",
    why: "部 (M1)(M4)(M5) の残りそのものである",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    sentence: "未形式化である。",
    kind: "残り",
    why: "部 (M4) の残りそのものである（名指しは前の文にある）",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    sentence: "**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。",
    kind: "済み",
    why: "cycle 39 step 2 で書いた（`CharacterDecompositionTwoVariable`）",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    sentence: "**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
    kind: "対象外",
    why: "散文自身が「本主張の残りではなく道具の一般性の話である」と書いている",
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    sentence: "未形式化である。",
    kind: "残り",
    why: "部 (U1a) の残りそのものである（名指しは前の文にある）",
  },
];
