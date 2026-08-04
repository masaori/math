/**
 * **検査 M の台帳**（本文で集合・添字族の上に取っている $\min$ / $\max$ の全数）。
 *
 * 型と、なぜ台帳制にするのかは `extremum-model.ts` の doc を正本とする。要点だけ:
 *
 * - **ここに載っていない出現は即座に赤くなる。** 新しく `\min\{\dots\}` を書けば、
 *   空になりうるかを判断して登録するまで `npm run check` が通らない。
 * - **根拠は 4 種類しかない**——構成から空でない／空でないことを本文が論じている／
 *   それを別のブロックが論じている（前方参照）／空になりうるので読み方を書いた。
 * - **目印を持つ 3 種類は、その一文が本文に実在することを機械が確かめる。**
 *   本文からその一文が消えれば赤くなる。「構成から空でない」だけは機械で確かめられない。
 * - **個数も見る。** 同じ指紋の出現が増減すれば赤くなる。
 *
 * 初期値は cycle 27 step 1 の全数走査（**42 指紋・44 出現**）。同 step で本文の 4 箇所を直した
 * （命題 G の (G1′) と (G6)、命題 J の $\theta$、命題 K・M・U の $S_\infty$ 上の $\max$、
 * 命題 W の $e_k$）。直す前は、それぞれ次のように読み方で主張が変わっていた。
 */

import type { ExtremumAllowance } from "./extremum-model.ts";

/** 有限個の元を並べた添字集合が空でない、という形の根拠を短く書くための下地。 */
const finiteIndex = (why: string): ExtremumAllowance["ground"] => ({
  type: "nonempty-by-construction",
  why,
});

export const EXTREMUM_ALLOWANCES: readonly ExtremumAllowance[] = [
  // --- 命題 N（Newton 多角形） ------------------------------------------------
  {
    block: "paper_044_theorem_newton",
    op: "min",
    form: "indexed",
    fingerprint: "i v_p(\\lambda_i)",
    count: 2,
    ground: finiteIndex(
      "添字 i は T ∈ M_d(ℤ) の固有値（特性多項式 χ_T の根、重複込みで d 個）を走る。" +
        "d ≥ 1 なので添字族は空でない。",
    ),
  },

  // --- 命題 W（トレース周期の梯子） ------------------------------------------
  {
    block: "paper_045_theorem_trace_ladder",
    op: "min",
    form: "indexed",
    fingerprint: "{0\\le N<r}v_p\\bigl(\\operatorname{Tr}(S^N(S^{p^m\\tau}-I))\\big",
    count: 1,
    ground: finiteIndex(
      "N は 0 ≤ N < r を走る。r は S の満たすモニック漸化式の階数で r ≥ 1 なので、" +
        "添字族は少なくとも N = 0 を含む。",
    ),
  },
  {
    block: "paper_045_theorem_trace_ladder",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{m\\ge0: g_m\\ge k\\}",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "g_m\\ge m+1" },
    note:
      "cycle 27 step 1 で直した箇所。直す前の本文は e_k = min{m : g_m ≥ k} と書くだけで、" +
      "この集合が空でない理由をどこにも書いていなかった。しかも近くにあるのは " +
      "「g_{m+1} = g_m + 1 は一般には成り立たない」という逆向きに読める一文だけだった。" +
      "S^τ ≡ I (mod p) から S^{p^m τ} ≡ I (mod p^{m+1}) が従い g_m ≥ m+1 となることを本文へ入れた。",
  },

  // --- 命題 A″（異なる w*） --------------------------------------------------
  {
    block: "paper_046_theorem_wstar_different",
    op: "max",
    form: "indexed",
    fingerprint: "{\\mathfrak p\\mid p}\\Bigl\\lceil \\frac{v_{\\mathfrak p}(\\eta)}{",
    count: 1,
    ground: finiteIndex(
      "𝔭 は代数体の整数環で p の上にある素イデアルを走る。p は有理素数なので p の上には" +
        "少なくとも 1 つ素イデアルがあり、添字族は空でない。",
    ),
  },
  {
    block: "paper_046_theorem_wstar_different",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{\\,j\\ge0:\\ p^{\\,j}\\eta^{-1}\\in A_{(p)}\\,\\},\\qquad \\det G=\\p",
    count: 1,
    ground: finiteIndex(
      "η ≠ 0 なので η^{-1} は分数体の元であり、局所化 A_(p) は離散付値環の有限個の積である。" +
        "j を十分大きく取れば p^j η^{-1} ∈ A_(p) となるので、この集合は空でない。",
    ),
  },
  {
    block: "paper_046_theorem_wstar_different",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{j:p^jA\\subseteq\\eta A\\ \\TEXTBODY{@}\\}=\\min\\{j:p^j\\eta^{-1}",
    count: 1,
    ground: finiteIndex("同じ集合を包含の言葉で書いたもの。空でない理由も同じ（η ≠ 0）。"),
  },
  {
    block: "paper_046_theorem_wstar_different",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{j:p^j\\eta^{-1}\\in A_{(p)}\\}",
    count: 1,
    ground: finiteIndex("上の 2 件と同じ集合。空でない理由も同じ（η ≠ 0）。"),
  },

  // --- 命題 G（低位項・退化点・消滅深度） ------------------------------------
  {
    block: "paper_053_theorem_lower_order",
    op: "min",
    form: "indexed",
    fingerprint: "{d<k}\\bigl(\\varepsilon_d(\\ell-1)+d\\bigr)-k",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\delta:=+\\infty" },
    note:
      "cycle 27 step 1 で直した箇所であり、本サイクルで見つかった中で最も射程が広い。" +
      "原本（cycle 17 report の命題 A (A.2)）は「d < k の項が無ければ δ := +∞」という規約を" +
      "明記していたのに、本文へ運ぶときに落ちていた。**空になるのは例外ではなく一般の場合である**——" +
      "実質の範囲は k_min ≤ d < k であり、これが空になるのは k = k_min、すなわち最低次部分が ℓ で" +
      "割れない一般の塔である。原本が挙げる検証例（k_min = 2 の 11 例、k = 2 の 5 例）は" +
      "すべてこの場合に入る。min∅ = 0 と読むと δ = −k < 0 となり、" +
      "十分条件が成り立つべき当の場合で成り立たなくなる。",
  },
  {
    block: "paper_053_theorem_lower_order",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{d:\\varepsilon_d<\\infty\\}",
    count: 1,
    ground: finiteIndex(
      "g ≠ 0 なので、ある次数 d の同次部分が 0 でなく、その ε_d は有限である。" +
        "したがって k_min を定める集合は空でない。",
    ),
  },
  {
    block: "paper_053_theorem_lower_order",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{m:\\ell\\nmid A_m(a_0,b_0)\\}",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\theta(P):=\\infty" },
    note:
      "cycle 27 step 1 で直した箇所。この集合が空になるのは「その方向で全ての A_m が ℓ で割れる」" +
      "場合であり、(G6) の仮定「全ての P で θ(P) ≤ ℓ」が成り立たない当の場合である。" +
      "min∅ = 0 と読むと θ(P) = 0 ≤ ℓ となって**仮定が偽から真へ反転し**、" +
      "仮定を満たさない塔へ結論を適用してしまう。既知の 2 件（定理 G2・命題 G′）が" +
      "ℓ = 3 だけを落としたのと違い、これは主張の適用範囲そのものを壊す向きの誤りである。",
  },

  // --- 命題 G′（θ = ∞ の段階的処理） ----------------------------------------
  {
    block: "paper_055_theorem_theta_infinity",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{m:\\ell\\nmid B_m\\}",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "\\theta^*<\\infty" },
    note:
      "Ψ は内容で割ったあとの多項式なので、係数のどれかは ℓ で割れない。" +
      "本文は「内容を 1 回割るだけで必ず θ* < ∞ になる」と明記している。",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{m<\\theta^*:B_m\\neq0\\}",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "m_1=+\\infty" },
    note: "cycle 26 step 6 が Lean で検出して直した箇所。min∅ = 0 と読むと ℓ = 3 だけが落ちる。",
  },

  // --- 命題 J（消滅深度の p 進化） --------------------------------------------
  {
    block: "paper_091_theorem_theta_padic",
    op: "max",
    form: "indexed",
    fingerprint: "in_i<\\ell^{L}",
    count: 1,
    ground: finiteIndex(
      "添字 i は相異なる γ_1, …, γ_k ∈ ℤ_ℓ を走る。この一次独立性の議論は k ≥ 1 の場合に" +
        "行われるので添字族は空でない。",
    ),
  },
  {
    block: "paper_091_theorem_theta_padic",
    op: "min",
    form: "indexed",
    fingerprint: "m\\bigl(\\varphi(\\ell^{M})v_\\ell(A_m)+m\\bigr)",
    count: 1,
    ground: finiteIndex(
      "m は A_m の添字（0 以上の整数）を走り、少なくとも m = 0 を含む。" +
        "値が +∞ になりうること（A_m = 0）と添字族が空であることは別である。",
    ),
  },
  {
    block: "paper_091_theorem_theta_padic",
    op: "min",
    form: "indexed",
    fingerprint: "{j\\ge0}\\bigl(e_j+j\\,\\ell^{r}\\bigr),",
    count: 1,
    ground: finiteIndex("添字族は {j ≥ 0} であり、少なくとも j = 0 を含むので空でない。"),
  },
  {
    block: "paper_091_theorem_theta_padic",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{j\\ge1: e_j<\\infty\\}",
    count: 1,
    ground: {
      type: "nonempty-argued-elsewhere",
      label: "paper_prop_K",
      marker: "e_{m_u}<\\infty",
    },
    note:
      "命題 J 自身はこの集合が空でないことを示していない（前方参照）。" +
      "cycle 27 step 1 で、その事実と埋める先を本文に明記した。",
  },
  {
    block: "paper_091_theorem_theta_padic",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{m:\\ell\\nmid A_m(a,b)\\}",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\theta(a,b):=\\infty" },
    note:
      "cycle 27 step 1 で直した箇所。本命題の主役 S_∞ = {P : θ(P) = ∞} はこの読みでしか" +
      "定義されない。min∅ = 0 と読むと S_∞ が常に空になり、nℓ^n の係数 b が常に 0 になる。",
  },

  // --- 命題 R（桁枝分解） ------------------------------------------------------
  {
    block: "paper_101_theorem_digit_branch",
    op: "max",
    form: "indexed",
    fingerprint: "{\\delta}v_\\ell(\\delta_1a+\\delta_2b)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "|\\mathcal{G}|\\le1" },
  },
  {
    block: "paper_101_theorem_digit_branch",
    op: "max",
    form: "indexed",
    fingerprint: "{\\delta}v_\\ell(\\delta_1a+\\delta_2b)}-1 \\qquad(\\TEXTBODY{@}\\d",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "|\\mathcal{G}|\\le1" },
    note: "本文は「そのような δ が 1 つも無ければ |𝒢| ≤ 1 なので θ(a,b) = 0」と書いている。",
  },
  {
    block: "paper_101_theorem_digit_branch",
    op: "min",
    form: "indexed",
    fingerprint: "c\\mathrm{ord}_y\\,g_c",
    count: 1,
    ground: finiteIndex("添字 c は {0, 1, …, ℓ−1} を走るので空でない（ℓ ≥ 2）。"),
  },
  {
    block: "paper_101_theorem_digit_branch",
    op: "min",
    form: "indexed",
    fingerprint: "m(\\varphi(\\ell^{M})v_\\ell(A_m)+m)",
    count: 1,
    ground: finiteIndex("命題 J の同じ量。添字 m は 0 以上の整数を走るので空でない。"),
  },
  {
    block: "paper_101_theorem_digit_branch",
    op: "min",
    form: "set-builder",
    fingerprint: "\\Bigl\\{s\\ge0:\\ \\sigma_s:=\\sum_{c\\in C}\\lambda_c\\binom{c}{s}\\",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "s^{*}\\le\\ell-1" },
    note:
      "本文が「s* は必ず存在して s* ≤ ℓ−1 を満たす」と明記し、二項係数の行列が 𝔽_ℓ 上可逆で" +
      "あることから (σ_s) ≠ 0 を導いている。",
  },
  {
    block: "paper_101_theorem_digit_branch",
    op: "min",
    form: "set-builder",
    fingerprint: "\\{t\\ge0:\\mathcal{G}\\ \\TEXTBODY{@}\\ \\bmod\\ \\ell^{t}\\ \\TEXTBOD",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "|\\mathcal{G}|\\le1" },
    note:
      "|𝒢| ≤ 1 なら t = 0 で条件が成り立つ。|𝒢| ≥ 2 なら 2 元の差が δ_1a + δ_2b (≠ 0) に等しく、" +
      "その ℓ 進付値は有限なので t = 1 + max_δ v_ℓ(δ_1a + δ_2b) で条件が成り立つ。" +
      "どちらの場合も集合は空でない。",
  },

  // --- 命題 K（S_∞ の判定） ---------------------------------------------------
  {
    block: "paper_101_theorem_s_infinity_decision",
    op: "max",
    form: "indexed",
    fingerprint: "{P\\neq P'}v_\\ell\\bigl(\\det(u,u')\\bigr),\\ \\max_{P}\\bigl\\lfloo",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    op: "max",
    form: "indexed",
    fingerprint: "{P\\neq P'}v_\\ell\\bigl(\\det(u,u')\\bigr),\\ \\max_{P}\\lambda_u\\B",
    count: 2,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
    note:
      "cycle 27 step 1 で直した箇所。S_∞ 上（前者は相異なる 2 点の対の上）を走るので空になりうる。" +
      "S_∞ = ∅ は本命題自身が (K6) で b = 0（型 II）として名指ししている場合であり、" +
      "|S_∞| = 1 のときは対が無いので前者だけが空になる。" +
      "既知の 2 件と違い、落ちるのは 1 つの素数ではなく本文が重要と宣言している場合そのものである。",
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    op: "max",
    form: "indexed",
    fingerprint: "{P}\\bigl\\lfloor\\log_\\ell e_{m_u}\\bigr\\rfloor\\Bigr)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    op: "max",
    form: "indexed",
    fingerprint: "{P}\\lambda_u\\Bigr) =1+\\max\\Bigl(\\max_{P\\neq P'}v_\\ell\\bigl(\\",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    op: "max",
    form: "indexed",
    fingerprint: "{P}\\lambda_u\\Bigr)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
  },

  // --- 命題 Q（仮定 (B*) を落とす） -------------------------------------------
  {
    block: "paper_106_theorem_drop_assumption",
    op: "max",
    form: "indexed",
    fingerprint: "i\\rho_i(P)",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "b\\ge1" },
    note:
      "添字 i は 1 ≤ i ≤ r を走る。この ρ_max を使う段は本文が「以下 b ≥ 1 とする」で始まっており、" +
      "b = Σ_{i=1}^{r} m_i かつ m_i ≥ 1 なので b ≥ 1 は r ≥ 1 を含意する。",
  },
  {
    block: "paper_106_theorem_drop_assumption",
    op: "min",
    form: "set-builder",
    fingerprint: "\\bigl\\{\\,c\\in\\mathbb{Z}_{\\ge0}\\ :\\ 2b<(\\ell-1)\\,\\ell^{c}\\,\\b",
    count: 1,
    ground: finiteIndex(
      "ℓ ≥ 2 なので (ℓ−1)ℓ^c は c について非有界であり、2b を超える c が存在する。" +
        "したがってこの集合は空でない。",
    ),
  },

  // --- 命題 M（一般の塔の閉形式） ---------------------------------------------
  {
    block: "paper_111_theorem_general_closed_form",
    op: "max",
    form: "indexed",
    fingerprint: "{P_0}",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
    note: "規約そのものが指している max_{P_0} の記号。cycle 27 step 1 で本文へ入れた。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "max",
    form: "indexed",
    fingerprint: "{P_0}K(P_0)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "max",
    form: "indexed",
    fingerprint: "{P_0}R'(P_0)\\bigr)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
    note:
      "cycle 27 step 1 で直した箇所。S_∞ 上を走るので空になりうる。空のとき r♯ = r_0、" +
      "U = ℙ^1(ℤ_ℓ) となって以下がそのまま読める。命題 K の r_0 と同じ規約。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "max",
    form: "set-builder",
    fingerprint: "\\bigl\\{k\\ge0:\\ j^{*}\\ell\\ge(\\ell-1)\\ell^{k}\\bigr\\}",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "j^{*}\\ge1" },
    note:
      "本文が「j* ≥ 1 より常に定義され、K ≥ 0」と明記している。実際 k = 0 では" +
      "j*ℓ ≥ ℓ > ℓ−1 が成り立つ。**この 1 件は本文が既に正しく処理していた例**である。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "indexed",
    fingerprint: "j\\bigl(e_j+j\\ell^{r}\\bigr)",
    count: 1,
    ground: finiteIndex("命題 J の Λ(r) と同じ量。添字族は {j ≥ 0} で空でない。"),
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "indexed",
    fingerprint: "m v(\\alpha_m)",
    count: 1,
    ground: finiteIndex(
      "α = Σ α_m x^m は 0 でない多項式なので添字 m の族は空でない" +
        "（非アルキメデス的付値の標準的な評価を書いた行）。",
    ),
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "indexed",
    fingerprint: "m v_\\ell\\bigl(A^{[k]}_m\\bigr),\\qquad \\theta^\\sharp_k:=\\min\\b",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "v_\\ell(0)=+\\infty" },
    note:
      "本文の規約により、この min は A^{[k]}_m ≠ 0 となる m についてのみ取る。" +
      "Φ^{[k]} ≠ 0 なのでそのような m は存在し、添字族は空でない。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "indexed",
    fingerprint: "m\\bigl(\\varphi(\\ell^{M})v_\\ell(A_m)+m\\bigr)",
    count: 1,
    ground: finiteIndex("命題 J の同じ量。添字 m は 0 以上の整数を走るので空でない。"),
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "set-builder",
    fingerprint: "\\bigl\\{m:v_\\ell(A^{[k]}_m)=\\Lambda_k\\bigr\\},\\qquad m^\\sharp_",
    count: 1,
    ground: { type: "nonempty-argued-here", marker: "v_\\ell(0)=+\\infty" },
    note:
      "Λ_k は有限個の m についての最小値なので必ず達成される。" +
      "したがって θ♯_k を定める集合は空でない。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    op: "min",
    form: "set-builder",
    fingerprint: "\\bigl\\{m<\\theta^\\sharp_k:A^{[k]}_m\\neq0\\bigr\\}",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "m^\\sharp_k=\\infty" },
    note:
      "命題 G′ の m_1 と同じ形。cycle 25 step 4b がこの本文を書いた時点で規約を入れていた" +
      "（cycle 26 総括が「他の命題に残っていないかは全数では見ていない」と書いた対象の 1 つで、" +
      "本 step の全数走査で**入っていることを確認した**）。",
  },

  // --- 命題 U（層ごとの係数） --------------------------------------------------
  {
    block: "paper_112_theorem_coefficient_layers",
    op: "max",
    form: "indexed",
    fingerprint: "{0\\le k\\le K(P_0)}\\Lambda_k(P_0)",
    count: 1,
    ground: finiteIndex("添字族は 0 ≤ k ≤ K(P_0) で、K ≥ 0 なので少なくとも k = 0 を含む。"),
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    op: "max",
    form: "indexed",
    fingerprint: "{P_0\\in S_\\infty}\\ \\max_{0\\le k\\le K(P_0)}\\Lambda_k(P_0)",
    count: 1,
    ground: { type: "empty-convention-stated", marker: "\\max\\emptyset:=0" },
    note:
      "cycle 27 step 1 で直した箇所。空のとき条件は N ≥ 1 と同値になる。" +
      "そのとき命題 K の (K6) より b = 0 で段データが空なので、決めるべきものが無く" +
      "条件が空であるのが正しい。",
  },
];
