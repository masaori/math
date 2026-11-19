import { defineNotes, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_def_finite_graph_connected_crossing_edge",
    targets: ["def_finite_graph_connected"],
    title: { text: "連結グラフの頂点分割をまたぐ辺" },
    body: [
      paragraph([
        "本文から退避した補題である。全域木の存在は辺を順に調べる論法で示しており、",
        "この補題を引用しない。",
      ]),
      paragraph([
        "有限連結グラフ ", math(String.raw`G=(V,E)`),
        " の空でなく全体でもない頂点集合 ", math(String.raw`U\subset V`),
        " に対し、", math(String.raw`a\in U`), " と ",
        math(String.raw`b\in V\setminus U`),
        " を端点とする辺がある。",
      ]),
      paragraph([
        "なければ、", math(String.raw`a`), " から ", math(String.raw`b`),
        " への路で ", math(String.raw`U`),
        " への所属が各辺に沿って保たれる。帰納法で ",
        math(String.raw`b\in U`), " となり、選び方に反する。",
      ]),
      paragraph(["有限例の検算と Lean の二版は保管する。"]),
    ],
  },
]);
