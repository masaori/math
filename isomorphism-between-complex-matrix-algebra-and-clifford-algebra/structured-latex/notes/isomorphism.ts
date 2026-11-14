import { defineNotes, math, paragraph, ref } from "../schema.ts";

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
    id: "note_isomorphism_theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms_correspondence_with_ising_paper",
    targets: ["theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms"],
    title: { text: "複素行列版イジングの論文の設定・記号との対応" },
    body: [
      paragraph([
        "複素行列版イジングの論文（exact-solution-of-2d-ising-model の structured-latex。ラベル def_kronecker、def_site_pauli_matrices、def_jordan_wigner_Z_matrices、def_jordan_wigner_Y_matrices を 2026-11-13 と 2026-11-14 に読んだ）は、",
        "各成分が 1 か 2 である組の全体を添字とし、組 ", math(String.raw`I`), " をあちらの論文の写像 ", math(String.raw`\nu`), " による番号 ", math(String.raw`\nu(I)=1+\sum_{k}(i_k-1)2^{M-k}`), " と同一視して ",
        math(String.raw`\mathrm{Mat}(2^{M},\mathbb{C})`), " のクロネッカー積を定める。本文はこの番号を ", math(String.raw`\mathrm{num}_M`), "（", ref("def_number_of_tuple_with_first_site_as_highest_digit"),
        "）として名前を付け、同一視の代わりに全単射であること（", ref("claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection"), "）を示してから、",
        "同じ形のクロネッカー積・サイトごとの Pauli 行列・", math(String.raw`Z^{(2^M)}_m`), "・", math(String.raw`Y^{(2^M)}_m`), " を定めた。",
      ]),
      paragraph([
        "あちらの虚数単位 ", math(String.raw`i`), " は、この本文の ", math(String.raw`\mathrm{i}`), "（", ref("def_imaginary_unit"), "）に当たり、", math(String.raw`(Y,Q)`), " を ",
        math(String.raw`(\mathbb{C}^{2M},\sum_a v_a^2)`), "、", math(String.raw`e`), " を標準基底にとった場合があちらの設定である。この場合に系の同型 ",
        math(String.raw`\widehat{\Omega}`), " は、", math(String.raw`\gamma_Y(e_m)`), "・", math(String.raw`\gamma_Y(e_{M+m})`), " をあちらの ", math(String.raw`Z_m`), "・", math(String.raw`Y_m`), " へ送る（",
        ref("claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix"), "、",
        ref("claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix"), "）。",
      ]),
      paragraph([
        "番号付け ", math(String.raw`r_M`), " は、本文の 2 進の番号付け（", ref("claim_binary_numbering_is_numbering_of_power_set"), " の写像。", math(String.raw`M`),
        " を含むかどうかが最上位の桁）とは桁の向きが逆である。2 進の番号付けで付け替えると、あちらの行列とは添字の並べ替えだけ違う行列になる。",
        "Jordan–Wigner の弦 ", math(String.raw`\sigma^x_1\cdots\sigma^x_{m-1}`), " は、生成作用素の行列の符号 ", math(String.raw`\varsigma(N_m(T))`), " を担うクロネッカー積の因子 ",
        math(String.raw`\sigma^z`), "（", math(String.raw`k<m`), "）を、", math(String.raw`K\sigma^z=\sigma^x K`), " で移したものである。",
      ]),
    ],
  },
]);
