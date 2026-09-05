import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_rule_definition_admissible_inputs",
    kind: "definition",
    title: { text: "周期境界と両立するオフセット入力" },
    labels: ["def_cyclic_admissible_inputs"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_offset_projection"), " の ", math(String.raw`L,r,q_v,M_v`),
        " と ", ref("def_state_set"), " の二元集合 ", math(String.raw`A`), " を用いて、"]),
      displayMath(String.raw`B_{L,r}:=\{a\in A^{D_r}:\ \forall j,k\in D_r,\
q_0(j)=q_0(k)\Rightarrow a(j)=a(k)\}`),
      paragraph(["と定める。", math(String.raw`0\in C_L`), " は整数の零である。",
        ref("claim_cyclic_offset_collision"), " により、定義中の ", math(String.raw`q_0`),
        " をどの ", math(String.raw`q_v`), " に置き換えても同じ集合になる。"]),
    ],
  },
  {
    id: "cyclic_rule_definition_pullback",
    kind: "definition",
    title: { text: "近傍の値をオフセット入力へ戻す写像" },
    labels: ["def_cyclic_input_pullback"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_admissible_inputs"), " の入力で、各 ", math(String.raw`v\in C_L`), " に対し"]),
      displayMath(String.raw`U_v:A^{M_v}\longrightarrow B_{L,r},\qquad
(U_vy)(j):=y(q_v(j))\quad(y\in A^{M_v},\ j\in D_r)`),
      paragraph(["と定める。", math(String.raw`q_v(j)\in M_v`), " なので評価できる。",
        ref("claim_cyclic_offset_collision"), " により同じ剰余を持つ二オフセットでは値が一致し、終域の条件を満たす。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_pullback_bijection",
    kind: "claim",
    title: { text: "実現可能な入力と重複を除いた近傍の値は全単射で対応する" },
    labels: ["claim_cyclic_input_pullback_bijection"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_input_pullback"), " の ", math(String.raw`U_v`), " は全単射である。"]),
    ],
    proof: [
      paragraph(["各 ", math(String.raw`w\in M_v`), " に対し、有限非空な整数集合 ",
        math(String.raw`\{j\in D_r:q_v(j)=w\}`), " の最小元を ", math(String.raw`s_v(w)\in D_r`),
        " とする。非空性は ", ref("def_cyclic_offset_projection"), " による。写像 ",
        math(String.raw`T_v:B_{L,r}\to A^{M_v}`), " を ", math(String.raw`(T_va)(w):=a(s_v(w))`),
        " で定める。", math(String.raw`a\in B_{L,r},j\in D_r`), " について"]),
      displayMath(String.raw`\begin{aligned}
(U_v(T_va))(j)&=(T_va)(q_v(j))\quad(\because\ \blkref{def_cyclic_input_pullback})\\
&=a(s_v(q_v(j)))\quad(\because\ T_v\text{ の定義})\\
&=a(j)\quad(\because\ \blkref{def_cyclic_admissible_inputs},\ q_v(s_v(q_v(j)))=q_v(j)).
\end{aligned}`),
      paragraph([math(String.raw`y\in A^{M_v},w\in M_v`), " についても"]),
      displayMath(String.raw`\begin{aligned}
(T_v(U_vy))(w)&=(U_vy)(s_v(w))\quad(\because\ T_v\text{ の定義})\\
&=y(q_v(s_v(w)))\quad(\because\ \blkref{def_cyclic_input_pullback})\\
&=y(w)\quad(\because\ s_v\text{ の選び方}).
\end{aligned}`),
      paragraph(["写像の外延性により両合成は恒等写像であり、相互逆である。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_input_realization",
    kind: "claim",
    title: { text: "両立入力は全配位から得られる入力を尽くす" },
    labels: ["claim_cyclic_input_realization"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_input_pullback"), " の入力で、各 ", math(String.raw`v\in C_L`), " について"]),
      displayMath(String.raw`\{\,j\mapsto x(q_v(j)):x\in A^{C_L}\,\}=B_{L,r}.`),
    ],
    proof: [
      paragraph(["左辺の元は ", math(String.raw`U_v(x|_{M_v})`), " に等しく（", ref("def_restriction_map"),
        "、", ref("def_cyclic_input_pullback"), "）、", math(String.raw`B_{L,r}`), " に属する。逆に ",
        math(String.raw`a\in B_{L,r}`), " を取る。", ref("claim_cyclic_input_pullback_bijection"),
        " により ", math(String.raw`U_vy=a`), " となる ", math(String.raw`y\in A^{M_v}`), " がある。配位を"]),
      displayMath(String.raw`x(w):=\begin{cases}
  y(w)&(w\in M_v),\\
  0&(w\in C_L\setminus M_v)
\end{cases}\qquad(w\in C_L)`),
      paragraph(["と定める。外の値は ", ref("def_state_set"), " の状態零であり、演算ではない。各 ",
        math(String.raw`j\in D_r`), " で"]),
      displayMath(String.raw`\begin{aligned}
x(q_v(j))&=y(q_v(j))\quad(\because\ q_v(j)\in M_v,\ x\text{ の定義})\\
&=(U_vy)(j)\quad(\because\ \blkref{def_cyclic_input_pullback})\\
&=a(j)\quad(\because\ U_vy=a).
\end{aligned}`),
      paragraph(["従って右辺の任意の元が左辺にも属する。"]),
    ],
  },
  {
    id: "cyclic_rule_definition_uniform_map",
    kind: "definition",
    title: { text: "有限巡回舞台上の半径付き一様規則の実現" },
    labels: ["def_cyclic_uniform_rule_map"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_input_pullback"), " の入力に対し、局所真理値表 ",
        math(String.raw`g:A^{D_r}\to A`), "（", ref("def_local_truth_table"), "）を一つ与える。",
        "舞台を ", math(String.raw`V:=C_L,\ N(v):=M_v`), " とし、局所規則を"]),
      displayMath(String.raw`f^{g}_v:A^{M_v}\to A,\qquad f^{g}_v(y):=g(U_vy)`),
      paragraph(["で定める。", math(String.raw`g`), " の評価では ", math(String.raw`B_{L,r}\subseteq A^{D_r}`),
        " の包含写像を経由する。", ref("def_global_map"), " の大域写像を ", math(String.raw`F_{L,r,g}`), " と書く。"]),
      displayMath(String.raw`(F_{L,r,g}x)(v)=g\bigl(j\mapsto x(q_v(j))\bigr)
\quad(x\in A^{C_L},\ v\in C_L).`),
      paragraph(["この表示は ", ref("def_restriction_map"), " と ", ref("def_cyclic_input_pullback"),
        " の代入で得られる。近傍を ", math(String.raw`q_v(j)`), " の重複を除いた集合に取るため、",
        "オフセット表そのものと各セルの局所規則を区別する。各剰余を代表する最小の ", math(String.raw`j\in D_r`),
        " を整数順に並べる番号付けは ", ref("claim_cyclic_offset_collision"),
        " により全セルで共通であり、その番号付けで局所規則は一様である。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_global_equality",
    kind: "claim",
    title: { text: "大域写像の等号は両立入力上の制限の等号と同値である" },
    labels: ["claim_cyclic_rule_global_equality"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_uniform_rule_map"), " の二つの表 ", math(String.raw`g,h:A^{D_r}\to A`), " について"]),
      displayMath(String.raw`F_{L,r,g}=F_{L,r,h}\quad\Longleftrightarrow\quad
 g|_{B_{L,r}}=h|_{B_{L,r}}.`),
      paragraph(["制限は ", ref("def_restriction_map"), " と同じく部分集合への評価の制限を表す。"]),
    ],
    proof: [
      paragraph(["右辺を仮定する。各 ", math(String.raw`x\in A^{C_L},v\in C_L`), " に対し、",
        ref("claim_cyclic_input_realization"), " から ", math(String.raw`a:=j\mapsto x(q_v(j))\in B_{L,r}`), "。従って"]),
      displayMath(String.raw`\begin{aligned}
(F_{L,r,g}x)(v)&=g(a)\quad(\because\ \blkref{def_cyclic_uniform_rule_map})\\
&=h(a)\quad(\because\ g|_{B_{L,r}}=h|_{B_{L,r}})\\
&=(F_{L,r,h}x)(v)\quad(\because\ \blkref{def_cyclic_uniform_rule_map}).
\end{aligned}`),
      paragraph(["写像の外延性を二回用いて大域写像は等しい。逆に左辺を仮定し ", math(String.raw`a\in B_{L,r}`),
        " を取る。", math(String.raw`0\in C_L`), " での ", ref("claim_cyclic_input_realization"),
        " により ", math(String.raw`a(j)=x(q_0(j))`), " となる ", math(String.raw`x\in A^{C_L}`), " がある。"]),
      displayMath(String.raw`\begin{aligned}
g(a)&=(F_{L,r,g}x)(0)\quad(\because\ \blkref{def_cyclic_uniform_rule_map})\\
&=(F_{L,r,h}x)(0)\quad(\because\ F_{L,r,g}=F_{L,r,h})\\
&=h(a)\quad(\because\ \blkref{def_cyclic_uniform_rule_map}).
\end{aligned}`),
      paragraph(["再び外延性により制限が等しい。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_input_count",
    kind: "claim",
    title: { text: "実現可能な入力の個数" },
    labels: ["claim_cyclic_admissible_input_count"],
    habitat: "N",
    statement: [
      paragraph([ref("def_cyclic_admissible_inputs"), " の入力について ", math(String.raw`m:=\min(L,2r+1)\in\mathbb N`), " と置くと、"]),
      displayMath(String.raw`|B_{L,r}|=2^m.`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
|B_{L,r}|&=|A^{M_0}|\quad(\because\ \blkref{claim_cyclic_input_pullback_bijection})\\
&=2^{|M_0|}\quad(\because\ \blkref{def_local_truth_table})\\
&=2^m\quad(\because\ \blkref{claim_cyclic_offset_image_count}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_rule_claim_table_count",
    kind: "claim",
    title: { text: "半径付きオフセット表の総数" },
    labels: ["claim_cyclic_rule_table_count"],
    habitat: "N",
    statement: [
      paragraph([ref("def_cyclic_uniform_rule_map"), " へ渡すオフセット表の集合を ", math(String.raw`\mathcal T_r:=A^{A^{D_r}}`), " と置くと、"]),
      displayMath(String.raw`|\mathcal T_r|=2^{\,2^{2r+1}}.`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
|\mathcal T_r|&=2^{|A^{D_r}|}\quad(\because\ \text{二元集合への写像の個数})\\
&=2^{\,2^{|D_r|}}\quad(\because\ \blkref{def_local_truth_table})\\
&=2^{\,2^{2r+1}}\quad(\because\ \blkref{def_integer_offset_interval}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_rule_claim_global_count",
    kind: "claim",
    title: { text: "有限巡回舞台で異なる一様大域写像の個数" },
    labels: ["claim_cyclic_uniform_global_count"],
    habitat: "N",
    statement: [
      paragraph([ref("claim_cyclic_rule_table_count"), " の表集合から得る写像の集合を ",
        math(String.raw`\mathcal G_{L,r}:=\{F_{L,r,g}:g\in\mathcal T_r\}`), " と置くと、"]),
      displayMath(String.raw`|\mathcal G_{L,r}|=2^{\,2^{\min(L,2r+1)}}.`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`b:B_{L,r}\to A`), " に対し ",
        math(String.raw`E(b):A^{D_r}\to A`), " を ", math(String.raw`a\in B_{L,r}`),
        " では ", math(String.raw`b(a)`), "、それ以外では状態零とする。",
        ref("claim_cyclic_rule_global_equality"), " より ",
        math(String.raw`b\mapsto F_{L,r,E(b)}`), " は単射である。また任意の ", math(String.raw`g\in\mathcal T_r`),
        " に対し ", math(String.raw`E(g|_{B_{L,r}})|_{B_{L,r}}=g|_{B_{L,r}}`),
        " なので、同じ主張により ", math(String.raw`F_{L,r,E(g|_{B_{L,r}})}=F_{L,r,g}`),
        "。従ってこの写像は全射でもある。"]),
      displayMath(String.raw`\begin{aligned}
|\mathcal G_{L,r}|&=|A^{B_{L,r}}|\quad(\because\ \text{上の全単射})\\
&=2^{|B_{L,r}|}\quad(\because\ \text{二元集合への写像の個数})\\
&=2^{\,2^{\min(L,2r+1)}}\quad(\because\ \blkref{claim_cyclic_admissible_input_count}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_rule_claim_fiber_count",
    kind: "claim",
    title: { text: "同じ大域写像を与えるオフセット表の個数" },
    labels: ["claim_cyclic_rule_realization_fiber_count"],
    habitat: "N",
    statement: [
      paragraph([ref("claim_cyclic_rule_table_count"), " の ", math(String.raw`g\in\mathcal T_r`), " に対して、"]),
      displayMath(String.raw`|\{h\in\mathcal T_r:F_{L,r,h}=F_{L,r,g}\}|
=2^{\,2^{2r+1}-2^{\min(L,2r+1)}}.`),
      paragraph(["指数の減法は自然数の減法であり、", math(String.raw`\min(L,2r+1)\le2r+1`), " により非負である。"]),
    ],
    proof: [
      paragraph([ref("claim_cyclic_rule_global_equality"), " により、表は ", math(String.raw`B_{L,r}`),
        " では ", math(String.raw`g`), " と一致し、その補集合では自由である。補集合上の写像 ",
        math(String.raw`c:A^{D_r}\setminus B_{L,r}\to A`), " を、", math(String.raw`B_{L,r}`),
        " 上で ", math(String.raw`g`), " に貼り合わせる写像と、補集合への制限が相互逆になる。従って"]),
      displayMath(String.raw`\begin{aligned}
|\{h\in\mathcal T_r:F_{L,r,h}=F_{L,r,g}\}|
&=2^{|A^{D_r}\setminus B_{L,r}|}\quad(\because\ \text{上の全単射と写像の個数})\\
&=2^{|A^{D_r}|-|B_{L,r}|}\quad(\because\ \text{有限部分集合の補集合の元数})\\
&=2^{\,2^{|D_r|}-|B_{L,r}|}\quad(\because\ \blkref{def_local_truth_table})\\
&=2^{\,2^{2r+1}-|B_{L,r}|}\quad(\because\ \blkref{def_integer_offset_interval})\\
&=2^{\,2^{2r+1}-2^{\min(L,2r+1)}}\quad(\because\ \blkref{claim_cyclic_admissible_input_count}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_rule_definition_elementary_encoding",
    kind: "definition",
    title: { text: "初等規則番号からオフセット表への写像" },
    labels: ["def_cyclic_elementary_encoding"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_state_set"), " の状態を自然数へ送る写像を ", math(String.raw`\epsilon:A\to\{0,1\}\subseteq\mathbb N`),
        "、逆写像を ", math(String.raw`\delta`), " とする（状態零を自然数零へ、状態一を自然数一へ送る）。",
        math(String.raw`a\in A^{D_1}`), " に対し ",
        math(String.raw`k(a):=4\epsilon(a(-1))+2\epsilon(a(0))+\epsilon(a(1))`), " と置く。",
        math(String.raw`R\in\{0,\ldots,255\}\subseteq\mathbb N`), " から表への写像を"]),
      displayMath(String.raw`g_R(a):=\delta\!\left(\left\lfloor R/2^{k(a)}\right\rfloor\bmod2\right)`),
      paragraph(["と定める。商と余りは自然数の除法であり、", ref("def_integer_offset_interval"),
        " の半径一を使う。状態集合へ演算を追加しない。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_elementary_encoding_bijection",
    kind: "claim",
    title: { text: "初等規則番号と半径一の表は全単射で対応する" },
    labels: ["claim_cyclic_elementary_encoding_bijection"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_elementary_encoding"), " の ", math(String.raw`R\mapsto g_R`),
        " は ", math(String.raw`\{0,\ldots,255\}\subseteq\mathbb N`), " から ",
        ref("claim_cyclic_rule_table_count"), " の ", math(String.raw`\mathcal T_1`), " への全単射である。"]),
    ],
    proof: [
      paragraph([ref("def_cyclic_elementary_encoding"), " の ",
        math(String.raw`k:A^{D_1}\to\{0,\ldots,7\}\subseteq\mathbb N`),
        " は三つの二進桁による全単射である。逆写像を ", math(String.raw`a_t:=k^{-1}(t)`),
        " とすると、表から番号への逆写像は ",
        math(String.raw`g\mapsto\sum_{t=0}^7\epsilon(g(a_t))2^t`),
        " である。自然数の二進展開の存在と一意性により各桁を取り出すと元の表に戻り、",
        "番号の八桁を再合成すると元の番号に戻る。従って両合成は恒等写像である。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_radius_one_comparison",
    kind: "claim",
    title: { text: "半径一の大域写像は左・自身・右の評価式と一致する" },
    labels: ["claim_cyclic_radius_one_comparison"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_elementary_encoding"), " の ", math(String.raw`g_R`),
        " に対し、", ref("def_cyclic_uniform_rule_map"), " の大域写像は次式を満たす。",
        math(String.raw`x\in A^{C_L},v\in C_L`), " とする。"]),
      displayMath(String.raw`(F_{L,1,g_R}x)(v)=\delta\!\left(\left\lfloor R/2^{K(x,v)}\right\rfloor\bmod2\right),`),
      displayMath(String.raw`K(x,v):=4\epsilon(x(\pi_L(v-1)))+2\epsilon(x(v))
+\epsilon(x(\pi_L(v+1))).`),
    ],
    proof: [
      paragraph([math(String.raw`a_{x,v}:=j\mapsto x(q_v(j))`), " と置く。"]),
      displayMath(String.raw`\begin{aligned}
(F_{L,1,g_R}x)(v)&=g_R(a_{x,v})\quad(\because\ \blkref{def_cyclic_uniform_rule_map})\\
&=\delta\!\left(\left\lfloor R/2^{k(a_{x,v})}\right\rfloor\bmod2\right)
\quad(\because\ \blkref{def_cyclic_elementary_encoding}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
k(a_{x,v})&=4\epsilon(x(q_v(-1)))+2\epsilon(x(q_v(0)))+\epsilon(x(q_v(1)))
\quad(\because\ \blkref{def_cyclic_elementary_encoding},\ a_{x,v}\text{ の定義})\\
&=4\epsilon(x(\pi_L(v-1)))+2\epsilon(x(\pi_L(v)))+\epsilon(x(\pi_L(v+1)))
\quad(\because\ \blkref{def_cyclic_offset_projection})\\
&=K(x,v)\quad(\because\ \pi_L(v)=v,\ K\text{ の定義}).
\end{aligned}`),
      paragraph(["最後の余りの等号は ", math(String.raw`v\in C_L`), " と ", ref("def_cyclic_integer_remainder"),
        " による。上の大域写像の式へ代入する。状態同士の加法や乗法は使っていない。"]),
    ],
  },
  {
    id: "cyclic_rule_claim_radius_one_collapse",
    kind: "claim",
    title: { text: "一セルと二セルでは異なる初等規則表が同じ大域写像を与える" },
    labels: ["claim_cyclic_radius_one_collapse"],
    habitat: "N",
    statement: [
      paragraph([ref("claim_cyclic_elementary_encoding_bijection"), " の256表について、異なる大域写像の個数は ",
        math(String.raw`L=1`), " で4、", math(String.raw`L=2`), " で16、", math(String.raw`L\ge3`),
        " で256である。一つの大域写像に対応する表の個数は順に64、16、1である。"]),
    ],
    proof: [
      paragraph([ref("claim_cyclic_uniform_global_count"), " に ", math(String.raw`r=1`), " を代入すると ",
        math(String.raw`2^{2^{\min(L,3)}}`), "。", math(String.raw`L=1,2`), " および ", math(String.raw`L\ge3`),
        " では内側の最小値は順に1、2、3なので、個数は4、16、256である。",
        ref("claim_cyclic_rule_realization_fiber_count"), " の同じ代入では ",
        math(String.raw`2^{8-2^{\min(L,3)}}`), " となり、順に64、16、1となる。"]),
      paragraph(["両立入力の条件は ", ref("def_cyclic_admissible_inputs"), " と ",
        ref("claim_cyclic_offset_collision"), " から、一セルでは ",
        math(String.raw`a(-1)=a(0)=a(1)`), "、二セルでは ", math(String.raw`a(-1)=a(1)`),
        " である。三セル以上では ", ref("claim_cyclic_offset_injective_boundary"),
        " の単射性により条件は自明となる。従って三〜六セルの既存校正に使った三つの近傍値は独立に指定できるが、",
        "一・二セルではそうではない。これは固定した周期舞台での写像の等号であり、無限舞台での規則の等号ではない。"]),
    ],
  },
]);
