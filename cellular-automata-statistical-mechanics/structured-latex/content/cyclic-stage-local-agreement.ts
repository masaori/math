import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_stage_local_agreement_definition_family",
    kind: "definition",
    title: { text: "有限巡回舞台の族と整数からの比較写像" },
    labels: ["def_cyclic_stage_family"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_integer_remainder"),
        " の有限集合と余り写像を、正の自然数全体で添字づけた族",
      ]),
      displayMath(String.raw`\mathcal C:=\bigl((C_L,\pi_L)\bigr)_{L\in\mathbb N_{>0}}`),
      paragraph([
        "とする。各 ",
        math(String.raw`C_L`),
        " は ",
        math(String.raw`L`),
        " 元の有限集合であり、比較写像 ",
        math(String.raw`\pi_L:\mathbb Z\to C_L`),
        " は整数をその有限剰余代表へ送る。この族全体は可算個の有限データからなる。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_window_relations",
    kind: "definition",
    title: { text: "有限窓で比較する等号関係" },
    labels: ["def_cyclic_stage_window_equality_relations"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " と ",
        ref("def_integer_offset_interval"),
        " を用いる。任意の ",
        math(String.raw`s\in\mathbb N`),
        " と ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " に対し、有限集合 ",
        math(String.raw`D_s\times D_s`),
        " の部分集合を",
      ]),
      displayMath(String.raw`E_{L,s}:=\{(j,k)\in D_s\times D_s:\pi_L(j)=\pi_L(k)\}`),
      displayMath(String.raw`E_{\mathbb Z,s}:=\{(j,k)\in D_s\times D_s:j=k\}`),
      paragraph([
        "と定める。前者は有限巡回舞台で同じセルへ移るオフセットの関係、後者は整数上の等号を同じ有限窓へ制限した関係である。どちらの所属も有限検査で決まる。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_eventual_exact_window_agreement",
    kind: "claim",
    title: { text: "有限巡回舞台の族は各有限窓で整数と完全に一致する" },
    labels: ["claim_cyclic_stages_eventually_match_integer_window"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_cyclic_stage_window_equality_relations"), " の関係について、"]),
      displayMath(String.raw`\forall s\in\mathbb N\ \exists L_0\in\mathbb N_{>0}\ \forall L\in\mathbb N_{>0}:\quad
L_0\le L\Longrightarrow E_{L,s}=E_{\mathbb Z,s}.`),
      paragraph([
        "特に ",
        math(String.raw`L_0:=2s+1`),
        " と取れる。これは誤差を導入せず、有限関係の完全な一致だけで述べた局所的一致である。実数体・複素数体・全配位空間・量の極限は使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s\in\mathbb N`),
        " を固定し、",
        math(String.raw`L_0:=2s+1`),
        " と置く。",
        math(String.raw`L\in\mathbb N_{>0}`),
        " が ",
        math(String.raw`L_0\le L`),
        " を満たすとする。",
        ref("claim_cyclic_offset_injective_boundary"),
        " を ",
        math(String.raw`r=s`),
        "、",
        math(String.raw`v=0`),
        " に適用すると、",
        math(String.raw`\pi_L|_{D_s}:D_s\to C_L`),
        " は単射である。従って任意の ",
        math(String.raw`j,k\in D_s`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(j,k)\in E_{L,s}
&\Longleftrightarrow \pi_L(j)=\pi_L(k)\quad(\because\ \blkref{def_cyclic_stage_window_equality_relations})\\
&\Longleftrightarrow j=k\quad(\because\ \pi_L|_{D_s}\text{ は単射})\\
&\Longleftrightarrow (j,k)\in E_{\mathbb Z,s}\quad(\because\ \blkref{def_cyclic_stage_window_equality_relations}).
\end{aligned}`),
      paragraph(["外延性により二つの有限関係は等しい。"]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_no_global_injection",
    kind: "claim",
    title: { text: "有限段階の比較写像は整数全体を埋め込まない" },
    labels: ["claim_cyclic_stage_projection_not_globally_injective"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " の任意の ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " について、比較写像 ",
        math(String.raw`\pi_L:\mathbb Z\to C_L`),
        " は単射でない。従って前の局所的一致を整数全体の埋め込みと同一視できない。無限舞台の全配位と有限段階の量の収束には別の定義と主張が必要であり、ここでは扱わない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_cyclic_integer_remainder"),
        " の ",
        math(String.raw`\ell=\iota(L)`),
        " は正の整数なので ",
        math(String.raw`0\ne\ell`),
        "。一方、余りの定義から",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_L(0)&=0\quad(\because\ 0=\ell\cdot0+0)\\
&=\pi_L(\ell)\quad(\because\ \ell=\ell\cdot1+0).
\end{aligned}`),
      paragraph(["相異なる二整数が同じ値を持つので、単射ではない。"]),
    ],
  },
]);
