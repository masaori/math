import { defineNotes, math, paragraph } from "../schema.ts";

// 章「同型の証明」に紐づく参照用ノート。文書本体ではないので最終成果物には載らない。

export default defineNotes([
  {
    id: "note_isomorphism_claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form_route_through_orthogonal_complement",
    targets: ["claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form"],
    title: { text: "採らなかった経路：直交する部分空間へ移って基底の長さで帰納する" },
    body: [
      paragraph([
        "よく知られた証明は、", math(String.raw`q(v)\neq 0`), " の元 ", math(String.raw`v`), " を取り、", math(String.raw`v`), " と ", math(String.raw`B_q`),
        " で直交する元の全体 ", math(String.raw`v^{\perp}`), " へ移って、その上で ", math(String.raw`q`), " が非退化であることと、",
        math(String.raw`b_j-\bigl(B_q(b_j,v)/B_q(v,v)\bigr)v`), " が ", math(String.raw`v^{\perp}`), " の基底であることを示し、基底の長さについての帰納法を回す。",
      ]),
      paragraph([
        "この経路では、部分空間 ", math(String.raw`v^{\perp}`), " を ℂ-線型空間として定め、",
        math(String.raw`v^{\perp}`), " の元を ", math(String.raw`V`), " の元として使うための包含写像に名前を付け、", math(String.raw`q`),
        " を ", math(String.raw`v^{\perp}`), " へ制限した写像が二次形式で非退化であることを示す必要がある。本文はこれを避け、",
        "元をすべて ", math(String.raw`V`), " の中に置いたまま、「第 k 元まで直交化された基底」の k についての帰納法で示した。",
        "基底の取り替えは「各元に一つの元の倍を足した族」の一種類だけで済み、非退化性は ", math(String.raw`V`), " の上で一度だけ使う。",
        "包含写像を通した行き来（同一視の置き場）が生じないので、この経路は採らなかった。",
      ]),
    ],
  },
  {
    id: "note_isomorphism_theorem_clifford_algebra_of_general_even_dimensional_space_sends_orthonormal_basis_to_jordan_wigner_matrices_correspondence_with_ising_paper",
    targets: ["theorem_clifford_algebra_of_general_even_dimensional_space_sends_orthonormal_basis_to_jordan_wigner_matrices"],
    title: { text: "複素行列版イジングの論文の行列との対応と、番号で添字づけた行列環へ移さなかった理由" },
    body: [
      paragraph([
        "複素行列版イジングの論文（exact-solution-of-2d-ising-model の structured-latex。ラベル def_kronecker、def_site_pauli_matrices、def_jordan_wigner_Z_matrices、def_jordan_wigner_Y_matrices を 2026-11-13 に読んだ）は、",
        math(String.raw`Z_m:=\sigma^x_1\cdots\sigma^x_{m-1}\sigma^z_m`), "、", math(String.raw`Y_m:=\sigma^x_1\cdots\sigma^x_{m-1}\sigma^y_m`), " をサイトごとの Pauli 行列の積として ",
        math(String.raw`\mathrm{Mat}(2^{M},\mathbb{C})`), " の中で定め、クロネッカー積の形に等しいことを別に示している。そのクロネッカー積は、添字の組 ",
        math(String.raw`(i_1,\dots,i_M)\in\{1,2\}^M`), " を ", math(String.raw`\nu(I)=1+\sum_{k}(i_k-1)2^{M-k}`), " で番号に移したもので、Pauli 行列の成分の添字 1・2 はこの本文の ",
        math(String.raw`o_T(k)`), " の 1・2 と同じ並びである（", math(String.raw`\sigma^z=\mathrm{diag}(1,-1)`), "）。したがって部分集合 ", math(String.raw`T`), " を番号 ",
        math(String.raw`1+\sum_{k\in T}2^{M-k}`), " へ移す番号付けで添字を付け替えると、この本文の ", math(String.raw`Z_m,Y_m`), " はあちらの ", math(String.raw`Z_m,Y_m`), " に一致する。",
        "あちらの虚数単位 ", math(String.raw`i`), " は、この本文では平方根の主張で選んだ ", math(String.raw`\mathrm{i}`), " に当たり、", math(String.raw`(Y,Q)`), " を ",
        math(String.raw`(\mathbb{C}^{2M},\sum_a v_a^2)`), "、", math(String.raw`e`), " を標準基底にとった場合があちらの設定である。",
      ]),
      paragraph([
        "この番号付けは、本文の 2 進の番号付け ", math(String.raw`e_M`), "（", math(String.raw`M\in e_M(k)`), " が最上位の桁）とは桁の向きが逆である。系を ",
        math(String.raw`\nu_{e_M}`), " で番号の行列環へ移すと、あちらの行列とは添字の並べ替えだけ違う行列になり、同じ記号で呼ぶと誤解を生む。",
        "そのため本文は系を番号付けに依らない ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " の中で述べ、クロネッカー積も部分集合全体で直接添字づけた。",
        "Jordan–Wigner の弦 ", math(String.raw`\sigma^x_1\cdots\sigma^x_{m-1}`), " は、生成作用素の行列の符号 ", math(String.raw`\varsigma(N_m(T))`), " を担うクロネッカー積の因子 ",
        math(String.raw`\sigma^z`), "（", math(String.raw`k<m`), "）を、", math(String.raw`K\sigma^z=\sigma^x K`), " で移したものである。",
      ]),
    ],
  },
]);
