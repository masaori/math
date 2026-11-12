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
]);
