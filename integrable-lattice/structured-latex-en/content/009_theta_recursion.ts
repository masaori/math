/**
 * 論文本体 第 11 章（英語版）: 消滅深度の桁枝再帰（命題 R）。
 *
 * **正本は日本語版 `../../structured-latex/content/009_theta_recursion.ts` である。**
 * ブロック id・`labels`・`habitat`・`verification`・`kind`・`proof` の有無、および**数式**は
 * 日本語版と完全に同じ文字列を使う（`tools/verify-ja-en-correspondence.ts` が検査する）。
 * 訳語は `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 *
 * ## 訳出で構造を変えた箇所（内容は変えていない）
 *
 * 日本語版は `**強調**` の中に数式ノード・`ref` を含めて書いている箇所が 3 つある（(R2) の
 * 「s* は必ず存在する」と「打ち消しは構造的に起こらない」、(R4) の「(J3) の仮定を使わない」）。
 * 英語版の生成器は**ノードをまたぐ `**` を拒否する**ので、強調文を数式なしで言い切り、
 * その直後に記号を対応づける文を置いた（用語集 §1.2d の前例と同じ扱い）。
 * **数式ノードの多重集合は日本語版と一致させてある。**
 *
 * ## 数式の中の日本語（`ja-en-exceptions.ts` へ登録した）
 *
 * (R3) の `\mathrm{sep}` の定義と、その下の displayMath の但し書きが `\text{}` の中に日本語を含む。
 * 英語版は和文フォントを読み込まないので、そのままだと PDF から無言で消える。
 * `\text{}` の中身を英訳した。日本語が後置修飾なので、英語として意味の通る語順にするために
 * `\text{}` の前後の記号の順を入れ替えた箇所がある。**記号そのものは 1 つも足しても消してもいない。**
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_100_heading_theta_recursion",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex-en/content/009_theta_recursion.ts", ordinal: 1 },
    title: {
      text:
        "No cancellation occurs — the digit-branch recursion for the vanishing depth, and the " +
        "valuation as a resultant",
    },
    labels: [],
  },
  {
    id: "paper_101_theorem_digit_branch",
    kind: "theorem",
    origin: { path: "structured-latex-en/content/009_theta_recursion.ts", ordinal: 2 },
    title: {
      text:
        "Proposition R — the vanishing depth determined by the digit-branch recursion, and the " +
        "valuation as a resultant",
    },
    labels: ["paper_prop_R"],
    habitat: "Qbar",
    verification: ["sagemath/check/cycle20_T3_cancellation"],
    statement: [
      paragraph([
        "We continue in the setting of ",
        ref("paper_prop_J"),
        ". For ",
        math(String.raw`\bar{\tilde E}=\sum\bar c_{pq}z^pw^q\in\mathbb{F}_\ell[z,w]`),
        " and primitive ",
        math(String.raw`(a,b)\in\mathbb{Z}_\ell^2`),
        ", collect the terms according to the value of the exponent ",
        math(String.raw`\gamma=pa+qb\in\mathbb{Z}_\ell`),
        " and write",
      ]),
      displayMath(
        String.raw`\overline{\Phi_{(a,b)}}(x)=\sum_{\gamma}\mu_\gamma\,(1+x)^{\gamma},
        \qquad \mu_\gamma=\sum_{pa+qb=\gamma}\bar c_{pq},`,
      ),
      paragraph([
        "Let ",
        math(String.raw`\mathcal{G}(a,b)`),
        " denote the set of all ",
        math(String.raw`\gamma`),
        " with ",
        math(String.raw`\mu_\gamma\neq0`),
        " (by part (J6) of ",
        ref("paper_prop_J"),
        " we have ",
        math(String.raw`\theta(a,b)=\infty\iff\mathcal{G}(a,b)=\emptyset`),
        ").",
      ]),
      paragraph([
        "**(R1 The digit-branch decomposition)** For ",
        math(String.raw`c\in\{0,\dots,\ell-1\}`),
        ", collect those elements of ",
        math(String.raw`\mathcal{G}`),
        " whose zeroth digit equals ",
        math(String.raw`c`),
        ", push them down by ",
        math(String.raw`\gamma\mapsto(\gamma-c)/\ell`),
        ", and write ",
        math(String.raw`\mathcal{G}_c`),
        " for the resulting family. Then, in ",
        math(String.raw`\mathbb{F}_\ell[[x]]`),
        ",",
      ]),
      displayMath(
        String.raw`\overline{\Phi_{(a,b)}}(x)=\sum_{c=0}^{\ell-1}(1+x)^{c}\,g_c(x^{\ell}),
        \qquad g_c(y)=\sum_{\gamma\in\mathcal{G}_c}\mu\,(1+y)^{\gamma}`,
      ),
      paragraph(["holds, by ", math(String.raw`(1+x)^{\ell}=1+x^{\ell}`), "."]),
      paragraph([
        "**(R2 No cancellation occurs)** Put ",
        math(String.raw`d:=\min_c\mathrm{ord}_y\,g_c`),
        " and ",
        math(String.raw`C:=\{c:\mathrm{ord}_y\,g_c=d\}`),
        ", and let ",
        math(String.raw`\lambda_c:=`),
        " denote the lowest-degree coefficient of ",
        math(String.raw`g_c`),
        ". Then",
      ]),
      displayMath(
        String.raw`\theta(a,b)=\ell\,d+s^{*},\qquad
        s^{*}=\min\Bigl\{s\ge0:\ \sigma_s:=\sum_{c\in C}\lambda_c\binom{c}{s}\neq0\Bigr\},`,
      ),
      paragraph([
        "and **the index occurring on the right always exists, and it is at most one less than the prime.** ",
        "The index in question is ",
        math(String.raw`s^{*}`),
        ", and the bound is ",
        math(String.raw`s^{*}\le\ell-1`),
        ". Indeed, for ",
        math(String.raw`0\le c,s\le\ell-1`),
        " the matrix ",
        math(String.raw`\bigl(\binom cs\bigr)_{c,s}`),
        " is lower triangular over ",
        math(String.raw`\mathbb{F}_\ell`),
        " with all diagonal entries equal to ",
        math(String.raw`1`),
        ", hence invertible; so ",
        math(String.raw`(\lambda_c)_{c\in C}\neq0`),
        " forces ",
        math(String.raw`(\sigma_s)_{0\le s\le\ell-1}\neq0`),
        ". ",
        "**Consequently the cancellation that prevented part (J2) from determining the vanishing depth — " +
          "the case in which the minimum is not attained at a single index — cannot occur in this " +
          "decomposition, for structural reasons.** The part in question is (J2) of ",
        ref("paper_prop_J"),
        ", and the quantity it left undetermined is ",
        math(String.raw`\theta`),
        ".",
      ]),
      paragraph([
        "**(R3 Finiteness and an effective upper bound)** Put",
      ]),
      displayMath(
        String.raw`\mathrm{sep}(a,b):=\min\{t\ge0:\ \text{the elements of}\ \mathcal{G}\ \text{are pairwise distinct}\ \bmod\ \ell^{t}\}`,
      ),
      paragraph([
        "Then the recursion of (R2) terminates at depth ",
        math(String.raw`\mathrm{sep}`),
        ", and",
      ]),
      displayMath(
        String.raw`\mathcal{G}\neq\emptyset\ \Longrightarrow\ \theta(a,b)\le\ell^{\mathrm{sep}(a,b)}-1<\infty.`,
      ),
      paragraph([
        "Furthermore, a difference of two elements of ",
        math(String.raw`\mathcal{G}`),
        " is a value ",
        math(String.raw`\delta_1a+\delta_2b`),
        " of a difference vector ",
        math(String.raw`\delta`),
        " of ",
        math(String.raw`S=\mathrm{supp}(\bar{\tilde E})`),
        ", so that",
      ]),
      displayMath(
        String.raw`\theta(a,b)\ \le\ \ell^{\,1+\max_{\delta}v_\ell(\delta_1a+\delta_2b)}-1
        \qquad(\text{the max is over those }\delta\text{ with }\delta_1a+\delta_2b\neq0),`,
      ),
      paragraph([
        "In other words, ",
        math(String.raw`\theta`),
        " grows only when ",
        math(String.raw`P=(a{:}b)`),
        " approaches, ",
        math(String.raw`\ell`),
        "-adically, one of the candidate points of ",
        math(String.raw`S_\infty`),
        " furnished by part (J6) of ",
        ref("paper_prop_J"),
        ", and that growth is bounded by the reciprocal of the distance to the candidate point. This is ",
        "stronger than the statement of part (J1) of ",
        ref("paper_prop_J"),
        ", that the depth is locally constant wherever it is finite, and it is **effective**.",
      ]),
      paragraph([
        "**(R4 The valuation as a resultant)** Put ",
        math(String.raw`\Psi_M(x):=\Phi_{\ell^{M}}(1+x)\in\mathbb{Z}[x]`),
        " (the minimal polynomial of ",
        math(String.raw`\pi=\zeta_{\ell^{M}}-1`),
        ", monic, of degree ",
        math(String.raw`\varphi(\ell^{M})`),
        "). If ",
        math(String.raw`E(\zeta^a,\zeta^b)\neq0`),
        ", then",
      ]),
      displayMath(
        String.raw`\hat\theta_{M}(a,b)=\varphi(\ell^{M})\,v_\ell\bigl(E(\zeta^a,\zeta^b)\bigr)
        =v_\ell\Bigl(\mathrm{Res}_x\bigl(\Psi_M,\ \Phi_{(a,b)}\bigr)\Bigr)`,
      ),
      paragraph([
        "holds. This follows from the fact that ",
        math(String.raw`\ell`),
        " is totally ramified in ",
        math(String.raw`\mathbb{Q}(\zeta_{\ell^{M}})`),
        " (ramification index ",
        math(String.raw`\varphi(\ell^{M})`),
        ", residue degree ",
        math(String.raw`1`),
        "), together with the fact that the resultant equals the norm ",
        math(String.raw`N_{\mathbb{Q}(\zeta_{\ell^{M}})/\mathbb{Q}}\bigl(\Phi_{(a,b)}(\pi)\bigr)`),
        ". ",
        "**The right-hand side is the valuation of a single integer, and it does not use the uniqueness " +
          "hypothesis that part (J3) imposed on the minimising index.** The valuation is the ",
        math(String.raw`\ell`),
        "-adic one, the part in question is (J3) of ",
        ref("paper_prop_J"),
        ", and the hypothesis was that the minimum in ",
        math(String.raw`\min_m(\varphi(\ell^{M})v_\ell(A_m)+m)`),
        " is attained at a single index.",
      ]),
      paragraph([
        "**(R5 Removing the hypotheses from the predictive algorithm)** Part (J3) of ",
        ref("paper_prop_J"),
        " decomposes by level as ",
        math(String.raw`\Sigma_n=\sum_{M=1}^{n}\Theta_M`),
        ", and this holds with no hypotheses; combining it with (R4), one obtains, provided ",
        math(String.raw`E`),
        " does not vanish at any root of unity of level ",
        math(String.raw`\le n`),
        ",",
      ]),
      displayMath(
        String.raw`\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)-2n+v_\ell(\kappa(X))
        +\sum_{M=1}^{n}\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M})}
        v_\ell\bigl(\mathrm{Res}_x(\Psi_M,\Phi_P)\bigr)`,
      ),
      paragraph([
        "which holds **with no hypotheses at all**. The right-hand side is settled by integer computation from the ",
        "coefficients of ",
        math(String.raw`D`),
        " alone (neither the values of the tower nor any computation in a cyclotomic field enters).",
      ]),
      paragraph(["**Limitations (stated as part of the assertion)**"]),
      list([
        [
          "What (R2) kills is the cancellation in part (J2) of ",
          ref("paper_prop_J"),
          ", not the tie between minimising indices in (J3). These are two distinct obstructions. For the ",
          "torus with ",
          math(String.raw`\ell=2`),
          ", the level-three quantity ",
          math(String.raw`\Theta_3`),
          " comes out as ",
          math(String.raw`40`),
          " from the sum in (J3) while the true value is ",
          math(String.raw`44`),
          ", and the latter obstruction is the cause. Removing it is the role of (R4).",
        ],
        [
          "(R5) **determines** ",
          math(String.raw`\mathrm{ord}_\ell(\kappa_n)`),
          " for each ",
          math(String.raw`n`),
          ", but it is **not a closed form** in ",
          math(String.raw`n`),
          " (the number of terms at level ",
          math(String.raw`M`),
          " grows as ",
          math(String.raw`(\ell+1)\ell^{M-1}`),
          "). A closed form remains a problem for parts (J4) and (J5) of ",
          ref("paper_prop_J"),
          ", and on the side of ",
          ref("paper_prop_G_infty"),
          ".",
        ],
        ["The present proposition is confined to ", math(String.raw`d=2`), "."],
        [
          "**We claim no novelty.** In the Iwasawa algebra ",
          math(String.raw`\mathbb{F}_\ell[[\mathbb{Z}_\ell]]\cong\mathbb{F}_\ell[[x]]`),
          ", parts (R1) and (R2) amount to a procedure that computes the ",
          math(String.raw`\lambda`),
          "-invariant of a measure with finite support along the ",
          math(String.raw`\ell`),
          "-adic tree of that support, and this is quite likely a standard tool. (R4) too is an ",
          "application of the standard fact that a resultant is a norm. We could not identify the ",
          "corresponding proposition in the literature.",
        ],
      ]),
    ],
  },
]);
