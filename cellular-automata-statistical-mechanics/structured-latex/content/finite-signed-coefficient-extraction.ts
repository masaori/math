/**
 * 有限全順序集合上の反交換生成子を、整数係数の有限表として定義する。
 * 最高次係数から有限整数行列を抽出できる範囲と、有限更新表を得るために別条件が要る境界を示す。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_signed_coefficient_extraction_remark_scope",
    kind: "remark",
    title: { text: "有限係数抽出の入力を固定する" },
    labels: ["remark_finite_signed_coefficient_extraction_scope"],
    habitat: "none",
    statement: [
      paragraph([
        "本節では、有限全順序集合、有限部分集合、整数係数、有限和だけを入力とする。",
        "反交換符号と最高次係数の抽出を有限代数として先に定義する。",
        "有限係数行列はこの抽出から作れるが、有限自己写像の零一指示行列との一致には別の条件が要る。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_tables",
    kind: "definition",
    title: { text: "有限外積係数表" },
    labels: ["def_finite_exterior_coefficient_table"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`I`), " を空でない有限全順序集合、", math(String.raw`\mathcal P(I)`),
        " をその冪集合とする。有限外積係数表の集合を",
      ]),
      displayMath(String.raw`\mathcal E_I:=\left\{a\mid a:\mathcal P(I)\to\mathbb Z\right\}`),
      paragraph(["と定める。", math(String.raw`a,b\in\mathcal E_I`), " と ", math(String.raw`c\in\mathbb Z`), " に対する加法と整数倍を"]),
      displayMath(String.raw`(a+b)(S):=a(S)+b(S),\qquad (ca)(S):=c\,a(S)\quad(S\subseteq I)`),
      paragraph([
        "で定める。", math(String.raw`\mathcal P(I)`), " は有限なので、各元は有限個の整数で尽き、",
        math(String.raw`\mathcal E_I`), " は高々可算である。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_basis",
    kind: "definition",
    title: { text: "部分集合で添字づけた基底係数表" },
    labels: ["def_finite_exterior_basis_table"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_coefficient_table"), " の各 ", math(String.raw`S\subseteq I`),
        " に対し、", math(String.raw`e_S\in\mathcal E_I`), " を",
      ]),
      displayMath(String.raw`e_S(U):=\begin{cases}1,&U=S,\\0,&U\ne S\end{cases}\qquad(U\subseteq I)`),
      paragraph([
        "で定める。また零係数表 ", math(String.raw`0_I\in\mathcal E_I`), " を ",
        math(String.raw`0_I(U):=0`), " で定める。各係数は整数である。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_product",
    kind: "definition",
    title: { text: "有限反交換積" },
    labels: ["def_finite_exterior_anticommuting_product"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_coefficient_table"), " の ", math(String.raw`a,b\in\mathcal E_I`),
        " に対し、積 ", math(String.raw`a\wedge b\in\mathcal E_I`), " を各 ", math(String.raw`U\subseteq I`), " で",
      ]),
      displayMath(String.raw`(a\wedge b)(U):=
\sum_{\substack{S,T\subseteq I\\S\cap T=\varnothing\\S\cup T=U}}
(-1)^{\nu(S,T)}a(S)b(T),
\qquad
\nu(S,T):=\left|\left\{(s,t)\in S\times T\mid t<s\right\}\right|`),
      paragraph([
        "と定める。添字集合は有限であり、", math(String.raw`\nu(S,T)\in\mathbb N`),
        " なので、右辺は整数の有限和である。共通の添字を持つ二項は和に入れない。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_claim_generator_relations",
    kind: "claim",
    title: { text: "一元基底は平方零で互いに反交換する" },
    labels: ["claim_finite_exterior_generators_square_zero_anticommute"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_basis_table"), " の ", math(String.raw`i,j\in I`), " に対し、",
      ]),
      displayMath(String.raw`e_{\{i\}}\wedge e_{\{i\}}=0_I`),
      paragraph(["が成り立つ。さらに ", math(String.raw`i\ne j`), " なら"]),
      displayMath(String.raw`e_{\{i\}}\wedge e_{\{j\}}=-e_{\{j\}}\wedge e_{\{i\}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\{i\}\cap\{i\}\ne\varnothing`), " なので、",
        ref("def_finite_exterior_anticommuting_product"), " の和には ",
        math(String.raw`S=T=\{i\}`), " の項が現れない。従って全係数が零になり、第一の等式を得る。",
      ]),
      paragraph([math(String.raw`i<j`), " の場合、定義から"]),
      displayMath(String.raw`\begin{aligned}
\nu(\{i\},\{j\})&=0,\\
\nu(\{j\},\{i\})&=1,
\end{aligned}`),
      paragraph(["なので"]),
      displayMath(String.raw`\begin{aligned}
e_{\{i\}}\wedge e_{\{j\}}
&=e_{\{i,j\}}
  \quad(\because\ \blkref{def_finite_exterior_anticommuting_product}),\\
e_{\{j\}}\wedge e_{\{i\}}
&=-e_{\{i,j\}}
  \quad(\because\ \blkref{def_finite_exterior_anticommuting_product}).
\end{aligned}`),
      paragraph([math(String.raw`j<i`), " の場合は ", math(String.raw`i,j`), " を入れ替えた同じ計算である。"]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_word_product",
    kind: "definition",
    title: { text: "有限語に沿う反交換単項式" },
    labels: ["def_finite_exterior_word_monomial"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`k\in\mathbb N`), " とし、", math(String.raw`[k]_{\mathbb N}:=\{r\in\mathbb N\mid 1\le r\le k\}`),
        " と置く。語 ", math(String.raw`w:[k]_{\mathbb N}\to I`), " の転倒数を",
      ]),
      displayMath(String.raw`\operatorname{inv}(w):=
\left|\left\{(r,s)\in[k]_{\mathbb N}^2\mid r<s\text{ かつ }w(s)<w(r)\right\}\right|`),
      paragraph(["と定め、その反交換単項式 ", math(String.raw`m_I(w)\in\mathcal E_I`), " を"]),
      displayMath(String.raw`m_I(w):=
\begin{cases}
(-1)^{\operatorname{inv}(w)}e_{w([k]_{\mathbb N})},&w\text{ が単射},\\
0_I,&w\text{ が単射でない}
\end{cases}`),
      paragraph([
        "で定める。", math(String.raw`k=0`), " では定義域と像がともに空であり、",
        math(String.raw`m_I(w)=e_{\varnothing}`), " である。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_claim_word_swap",
    kind: "claim",
    title: { text: "異なる隣接二文字の交換は符号だけを反転する" },
    labels: ["claim_finite_exterior_word_adjacent_swap_sign"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_word_monomial"), " の単射な語 ", math(String.raw`w:[k]_{\mathbb N}\to I`),
        " と ", math(String.raw`1\le r<k`), " を取る。", math(String.raw`w'`),
        " を位置 ", math(String.raw`r,r+1`), " の値だけ交換した語とすると、",
      ]),
      displayMath(String.raw`m_I(w')=-m_I(w)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`w`), " は単射なので交換する二文字は異なり、", math(String.raw`w'`),
        " も単射で像集合は同じである。隣接交換では交換した二文字の相対順序だけが変わるため、",
      ]),
      displayMath(String.raw`\operatorname{inv}(w')=
\begin{cases}
\operatorname{inv}(w)+1,&w(r)<w(r+1),\\
\operatorname{inv}(w)-1,&w(r+1)<w(r).
\end{cases}`),
      paragraph(["従って二つの転倒数の偶奇は反対であり、"]),
      displayMath(String.raw`\begin{aligned}
m_I(w')
&=(-1)^{\operatorname{inv}(w')}e_{w'([k]_{\mathbb N})}
  \quad(\because\ \blkref{def_finite_exterior_word_monomial})\\
&=-(-1)^{\operatorname{inv}(w)}e_{w([k]_{\mathbb N})}
  \quad(\because\ \text{転倒数の偶奇が反対で像集合が等しい})\\
&=-m_I(w)
  \quad(\because\ \blkref{def_finite_exterior_word_monomial}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_top_coefficient",
    kind: "definition",
    title: { text: "最高次係数の抽出" },
    labels: ["def_finite_exterior_top_coefficient"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_coefficient_table"), " の ", math(String.raw`a\in\mathcal E_I`), " に対し、最高次係数を",
      ]),
      displayMath(String.raw`\operatorname{Top}_I(a):=a(I)\in\mathbb Z`),
      paragraph([
        "で定める。これは有限係数表の一成分を読む写像であり、解析的な積分、極限、除算、対数を使わない。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_claim_basis_permutation_sign",
    kind: "claim",
    title: { text: "全基底の並べ替えは最高次係数へ置換符号を与える" },
    labels: ["claim_finite_exterior_basis_permutation_top_sign"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`n:=|I|\in\mathbb N_{>0}`), " とし、", math(String.raw`\iota:[n]_{\mathbb N}\to I`),
        " を順序を保つ全単射とする。任意の全単射 ", math(String.raw`\pi:[n]_{\mathbb N}\to[n]_{\mathbb N}`),
        " に対し、語 ", math(String.raw`w_\pi:=\iota\circ\pi`), " は",
      ]),
      displayMath(String.raw`\operatorname{Top}_I\!\left(m_I(w_\pi)\right)
=(-1)^{\operatorname{inv}(w_\pi)}\in\{-1,1\}`),
      paragraph([
        "を満たす。従って基底順序の変更が最高次係数へ加える情報は、有限置換の転倒数の偶奇で決まる整数符号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\iota`), " と ", math(String.raw`\pi`), " は全単射なので ",
        math(String.raw`w_\pi`), " も全単射であり、その像は ", math(String.raw`I`), " である。従って",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{Top}_I\!\left(m_I(w_\pi)\right)
&=\operatorname{Top}_I\!\left((-1)^{\operatorname{inv}(w_\pi)}e_I\right)
  \quad(\because\ \blkref{def_finite_exterior_word_monomial})\\
&=(-1)^{\operatorname{inv}(w_\pi)}e_I(I)
  \quad(\because\ \blkref{def_finite_exterior_top_coefficient})\\
&=(-1)^{\operatorname{inv}(w_\pi)}
  \quad(\because\ \blkref{def_finite_exterior_basis_table}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_claim_finite_decidable",
    kind: "claim",
    title: { text: "反交換積と最高次係数は有限整数計算で決定できる" },
    labels: ["claim_finite_signed_coefficient_extraction_decidable"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_exterior_coefficient_table"), " の二つの係数表について、",
        ref("def_finite_exterior_anticommuting_product"), " の全係数と ",
        ref("def_finite_exterior_top_coefficient"), " の値は、有限集合の列挙と整数の加法・乗法・等号比較だけで決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal P(I)`), " は有限である。各 ", math(String.raw`U\subseteq I`),
        " に対し、積の定義で走査する ", math(String.raw`(S,T)\in\mathcal P(I)^2`),
        " も有限個であり、交叉・合併・転倒対の個数・整数符号・整数積・整数和は全て有限手続きで求まる。",
        "最高次係数は得られた表の ", math(String.raw`I`), " 成分を一度読むだけである。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_matrix",
    kind: "definition",
    title: { text: "有限族から抽出する整数係数行列" },
    labels: ["def_finite_top_coefficient_matrix"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`B`), " を空でない有限集合とし、", math(String.raw`K:B\times B\to\mathcal E_I`),
        " を有限外積係数表の族とする。行を入力 ", math(String.raw`x\in B`),
        "、列を出力 ", math(String.raw`y\in B`), " で添字づける整数係数行列 ",
        math(String.raw`Q_K\in\mathbb Z^{B\times B}`), " を",
      ]),
      displayMath(String.raw`Q_K(x,y):=\operatorname{Top}_I\!\left(K(x,y)\right)`),
      paragraph([
        "で定める。行列の抽出自体は有限表の成分読み出しであり、自己写像、確率、実数体、複素数体を仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_definition_update_indicator",
    kind: "definition",
    title: { text: "有限舞台上の大域写像の零一指示行列" },
    labels: ["def_finite_self_map_indicator_matrix"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_ca"), " の有限舞台上の 2 値セルオートマトンを取り、有限配位集合を ",
        math(String.raw`X:=A^V`), "、", ref("def_global_map"), " の大域写像を ",
        math(String.raw`F:X\to X`), " とする。", math(String.raw`F`), " の零一指示行列 ",
        math(String.raw`D_F\in\{0,1\}^{X\times X}`), " を",
      ]),
      displayMath(String.raw`D_F(x,y):=\begin{cases}1,&y=F(x),\\0,&y\ne F(x)
\end{cases}\qquad(x,y\in X)`),
      paragraph(["で定める。各行には一がちょうど一つある。"]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_claim_matrix_not_update",
    kind: "claim",
    title: { text: "最高次係数行列だけでは有限更新写像は定まらない" },
    labels: ["claim_finite_top_coefficient_matrix_not_automatically_update"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_top_coefficient_matrix"), " の整数係数行列は、一般には ",
        ref("def_finite_self_map_indicator_matrix"), " の形ではない。従って符号付き係数抽出を 2 値セルオートマトンの大域写像そのものと同一視できない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`I:=\{i\}`), " と一セル舞台 ", math(String.raw`V:=\{v\}`),
        " を取り、配位集合を ", math(String.raw`X=A^V=\{x_0,x_1\}`), " と書く。",
        math(String.raw`K(x_0,x_0):=-e_I`), "、それ以外の ", math(String.raw`(x,y)\in X^2`),
        " では ", math(String.raw`K(x,y):=0_I`), " と定める。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_K(x_0,x_0)
&=\operatorname{Top}_I(-e_I)
  \quad(\because\ \blkref{def_finite_top_coefficient_matrix})\\
&=-1
  \quad(\because\ \blkref{def_finite_exterior_top_coefficient}\text{ と }\blkref{def_finite_exterior_basis_table}).
\end{aligned}`),
      paragraph([
        "一方、任意の大域写像 ", math(String.raw`F:X\to X`), " について ",
        math(String.raw`D_F(x_0,x_0)\in\{0,1\}`), " である。従って全ての ",
        math(String.raw`F`), " について ", math(String.raw`Q_K\ne D_F`), " である。",
      ]),
    ],
  },
  {
    id: "finite_signed_coefficient_extraction_remark_continuum_boundary",
    kind: "remark",
    title: { text: "有限係数抽出から連続構造は従わない" },
    labels: ["remark_finite_signed_coefficient_extraction_continuum_boundary"],
    habitat: "none",
    statement: [
      paragraph([
        ref("claim_finite_signed_coefficient_extraction_decidable"), " と ",
        ref("def_finite_top_coefficient_matrix"), " は、整数係数の有限表と有限行列までを与える。",
        ref("claim_finite_top_coefficient_matrix_not_automatically_update"),
        " により、2 値セルオートマトンの大域写像との対応さえ係数抽出だけからは従わない。従って連続時間発展、連続 Lorentz 対称性、",
        "Dirac 型または Thirring 型の方程式、Pfaffian 表現も本節からは主張しない。",
        "それらを比較するには、比較対象・比較写像・保存される構造・極限または誤差の概念を別に定義する必要がある。",
      ]),
    ],
  },
]);
