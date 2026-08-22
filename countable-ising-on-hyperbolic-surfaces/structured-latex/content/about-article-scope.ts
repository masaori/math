import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "article_scope_definition_finite_quotient_regular_cellulated_closed_hyperbolic_surface",
    kind: "definition",
    title: { text: "有限商正則セル分割付き閉双曲曲面" },
    labels: ["def_finite_quotient_regular_cellulated_closed_hyperbolic_surface"],
    habitat: "mixed",
    realEscape:
      "正則双曲多角形による計量的実現と曲率 -1 の計量 h だけが実数を用いる。有限商データ、有限セル分割、正則型、双曲不等式の判定は有限集合と自然数に属する。",
    statement: [
      paragraph([
        "有限商正則セル分割付き閉双曲曲面とは、次のデータの組",
      ]),
      displayMath(String.raw`(\mathcal Q,X,p,q,h)`),
      paragraph([
        "である。ここで ",
        math(String.raw`\mathcal Q`),
        " は有限群とその部分群の剰余類からなる有限商データ、",
        math(String.raw`X`),
        " は ",
        math(String.raw`\mathcal Q`),
        " から生成される向き付けられた閉曲面の有限セル分割、",
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " は ",
        math(String.raw`X`),
        " の全ての面が ",
        math(String.raw`p`),
        " 本の辺をもち、全ての頂点に ",
        math(String.raw`q`),
        " 個の面が接することを表す正則型 ",
        math(String.raw`\{p,q\}`),
        " である。さらに、",
      ]),
      displayMath(String.raw`\frac{1}{p}+\frac{1}{q}<\frac{1}{2}`),
      paragraph([
        "を満たし、",
        math(String.raw`h`),
        " は内角 ",
        math(String.raw`2\pi/q`),
        " の正則双曲 ",
        math(String.raw`p`),
        " 角形を ",
        math(String.raw`X`),
        " の面の貼り合わせ規則に従って貼ることで得られる曲率 ",
        math(String.raw`-1`),
        " の計量である。このような組全体の集合を",
      ]),
      displayMath(String.raw`\mathcal H_{\mathrm{fq}}`),
      paragraph(["と書き、本論文ではこの集合を対象とする。"]),
    ],
  },
]);
