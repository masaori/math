/**
 * 固定した有限表から組合せ散乱データを定義し、内部状態の有限検査と
 * 整数位相を伴う高々可算なアフィン持ち上げを分離する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_combinatorial_scattering_data_definition_internal_tables",
    kind: "definition",
    title: { text: "有限内部散乱表" },
    labels: ["def_finite_internal_scattering_tables"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`B,C,I`), " を空でない有限集合とし、", math(String.raw`0_I\in I`),
        " を指定する。", math(String.raw`\bot`), " をこれらの集合に属さない記号とする。各 ",
        math(String.raw`i\in I`), " について部分作用表を全域写像として",
      ]),
      displayMath(String.raw`E_i^{BC}:B\times C\longrightarrow(B\times C)\sqcup\{\bot\},
\qquad
E_i^{CB}:C\times B\longrightarrow(C\times B)\sqcup\{\bot\}`),
      paragraph([
        "で与える。さらに、値が ", math(String.raw`\bot`), " でない入力について、作用した因子を記録する有限表",
      ]),
      displayMath(String.raw`S_i^{BC}:\{u\in B\times C\mid E_i^{BC}(u)\ne\bot\}\longrightarrow\{\mathsf L,\mathsf R\},
\qquad
S_i^{CB}:\{v\in C\times B\mid E_i^{CB}(v)\ne\bot\}\longrightarrow\{\mathsf L,\mathsf R\}`),
      paragraph([
        "と全単射 ", math(String.raw`R_{BC}:B\times C\to C\times B`),
        " を与える。これらを有限内部散乱表と呼ぶ。集合、直積、部分作用表、左右の標識、全単射以外の構造は仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_operator_compatibility",
    kind: "definition",
    title: { text: "内部散乱表と部分作用表の可換性" },
    labels: ["def_internal_scattering_operator_compatibility"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_internal_scattering_tables"), " の全単射を ", math(String.raw`R_{BC}(\bot):=\bot`),
        " と延長する。全ての ", math(String.raw`i\in I`), " と ", math(String.raw`u\in B\times C`), " について",
      ]),
      displayMath(String.raw`R_{BC}\bigl(E_i^{BC}(u)\bigr)=E_i^{CB}\bigl(R_{BC}(u)\bigr)`),
      paragraph([
        "が成り立つとき、内部散乱表は部分作用表と可換であるという。これは二つの有限表の値の等号である。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_integer_difference",
    kind: "definition",
    title: { text: "整数値表の差分適合条件" },
    labels: ["def_internal_scattering_integer_difference_compatibility"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_finite_internal_scattering_tables"), " と ", ref("def_internal_scattering_operator_compatibility"),
        " を満たす表に対し、整数値関数 ", math(String.raw`H_{BC}:B\times C\to\mathbb Z`), " を与える。",
        math(String.raw`E_i^{BC}(u)\ne\bot`), " である各 ", math(String.raw`(i,u)\in I\times(B\times C)`), " について",
      ]),
      displayMath(String.raw`H_{BC}\bigl(E_i^{BC}(u)\bigr)-H_{BC}(u)
=
\begin{cases}
  1,
  & i=0_I,\ S_i^{BC}(u)=\mathsf L,\
    S_i^{CB}(R_{BC}(u))=\mathsf L,\\
  -1,
  & i=0_I,\ S_i^{BC}(u)=\mathsf R,\
    S_i^{CB}(R_{BC}(u))=\mathsf R,\\
  0,
  & \text{その他}
\end{cases}`),
      paragraph([
        "が成り立つとき、", math(String.raw`H_{BC}`), " は整数値差分適合条件を満たすという。",
        "整数の加法、減法、等号だけを使い、除算、対数、実数、複素数を使わない。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_integer_normalization",
    kind: "definition",
    title: { text: "整数値表の正規化" },
    labels: ["def_internal_scattering_integer_normalization"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_internal_scattering_integer_difference_compatibility"), " の ", math(String.raw`H_{BC}`),
        " に対し、基準入力 ", math(String.raw`u_\ast\in B\times C`), " と基準整数 ",
        math(String.raw`h_\ast\in\mathbb Z`), " を指定する。等式",
      ]),
      displayMath(String.raw`H_{BC}(u_\ast)=h_\ast`),
      paragraph([
        "を整数値表の正規化条件と呼ぶ。差分適合条件だけでは ", math(String.raw`H_{BC}`),
        " への整数定数の加算を区別しないため、絶対的な整数位相を使うときは正規化を入力に含める。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_claim_finite_checks_decidable",
    kind: "claim",
    title: { text: "有限内部散乱表の適合条件は別々に有限決定できる" },
    labels: ["claim_finite_internal_scattering_compatibilities_decidable"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_finite_internal_scattering_tables"), " の固定した有限表に対し、",
        ref("def_internal_scattering_operator_compatibility"), " の可換性、",
        ref("def_internal_scattering_integer_difference_compatibility"), " の差分適合条件、",
        ref("def_internal_scattering_integer_normalization"), " の正規化条件は、それぞれ有限回の等号比較で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "可換性は有限集合 ", math(String.raw`I\times(B\times C)`), " の全入力について二つの有限表の値を比較すれば決まる。",
        "差分適合条件は同じ有限集合のうち部分作用表の値が ", math(String.raw`\bot`),
        " でない入力だけを走査し、整数差と ", math(String.raw`\{-1,0,1\}`), " の指定値を比較すれば決まる。",
        "正規化条件は指定した一入力における二整数の等号比較で決まる。",
        "従って三条件は互いを同一視せず、別々の有限手続きで決定できる。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_affinization_and_lift",
    kind: "definition",
    title: { text: "有限内部散乱表のアフィン化と整数位相持ち上げ" },
    labels: ["def_internal_scattering_affine_lift"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_internal_scattering_integer_normalization"), " までを満たすデータに対し、",
        math(String.raw`\operatorname{Aff}(B):=\mathbb Z\times B`), " と ",
        math(String.raw`\operatorname{Aff}(C):=\mathbb Z\times C`), " を定める。",
        math(String.raw`R_{BC}(b,c)=(\widetilde c,\widetilde b)`), " のとき、写像",
      ]),
      displayMath(String.raw`\widehat R_{BC}:\operatorname{Aff}(B)\times\operatorname{Aff}(C)
\longrightarrow
\operatorname{Aff}(C)\times\operatorname{Aff}(B)`),
      displayMath(String.raw`\widehat R_{BC}\bigl((d,b),(d',c)\bigr)
:=
\Bigl(
  \bigl(d'+H_{BC}(b,c),\widetilde c\bigr),
  \bigl(d-H_{BC}(b,c),\widetilde b\bigr)
\Bigr)`),
      paragraph([
        "を整数位相持ち上げと呼ぶ。", math(String.raw`B,C`), " は有限だが ",
        math(String.raw`\mathbb Z\times B,\mathbb Z\times C`),
        " は高々可算であり、有限集合とは主張しない。使う演算は整数の加法と減法だけである。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_affine_yang_baxter_compatibility",
    kind: "definition",
    title: { text: "三つの整数位相持ち上げの Yang–Baxter 適合条件" },
    labels: ["def_internal_scattering_affine_yang_baxter_compatibility"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`B,C,D`), " を空でない有限集合とし、各組に ",
        ref("def_internal_scattering_affine_lift"), " の持ち上げ ",
        math(String.raw`\widehat R_{BC},\widehat R_{BD},\widehat R_{CD}`), " が与えられているとする。",
        "各恒等写像を ", math(String.raw`\operatorname{id}_B,\operatorname{id}_C,\operatorname{id}_D`),
        " と書く。合成を右から左へ適用する写像の等式",
      ]),
      displayMath(String.raw`(\widehat R_{CD}\times\operatorname{id}_B)
(\operatorname{id}_C\times\widehat R_{BD})
(\widehat R_{BC}\times\operatorname{id}_D)
=
(\operatorname{id}_D\times\widehat R_{BC})
(\widehat R_{BD}\times\operatorname{id}_C)
(\operatorname{id}_B\times\widehat R_{CD})`),
      paragraph([
        "が ", math(String.raw`\operatorname{Aff}(B)\times\operatorname{Aff}(C)\times\operatorname{Aff}(D)`),
        " から ", math(String.raw`\operatorname{Aff}(D)\times\operatorname{Aff}(C)\times\operatorname{Aff}(B)`),
        " への写像の等号として成り立つことを、アフィン Yang--Baxter 適合条件と呼ぶ。",
        "これは高々可算な整数位相を含む条件であり、内部表の有限性だけから自動的に従うとは定めない。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_definition_crystallization_extraction",
    kind: "definition",
    title: { text: "正規化された q 依存作用素の結晶化抽出" },
    labels: ["def_normalized_q_operator_crystallization_extraction"],
    habitat: "mixed",
    realEscape:
      "結晶化前の比較元を記述するため複素係数の有理関数を用いる。q=0 で正則な係数の代数的評価だけを使い、解析的極限、位相、内積、完備性は用いない。",
    statement: [
      paragraph([
        math(String.raw`q,z`), " を不定元とし、",
        math(String.raw`\mathcal O_0:=\{f\in\mathbb C(q):f\text{ は }q=0\text{ で正則}\}`),
        " と置く。", math(String.raw`\mathcal L_z`), " を ", math(String.raw`z`),
        " の複素 Laurent 多項式環、",
        math(String.raw`\mathcal A_0:=\mathcal O_0\otimes_{\mathbb C}\mathcal L_z`),
        " とし、係数ごとの評価写像を ",
        math(String.raw`\operatorname{ev}_0:\mathcal A_0\to\mathcal L_z`),
        " とする。空でない有限集合 ", math(String.raw`B,C`), " に対し、基底をそれぞれ ",
        math(String.raw`\{e_b:b\in B\}`), " と ", math(String.raw`\{e_c:c\in C\}`), " で標識する。",
      ]),
      displayMath(String.raw`\mathcal M_{BC}:=
\bigoplus_{(b,c)\in B\times C}\mathcal A_0(e_b\otimes e_c),
\qquad
\mathcal M_{CB}:=
\bigoplus_{(c,b)\in C\times B}\mathcal A_0(e_c\otimes e_b)`),
      paragraph([
        "と置き、", math(String.raw`\operatorname{ev}_0`),
        " を両自由加群へ係数ごとに延長する。", math(String.raw`\mathcal A_0`), " 上の同型 ",
        math(String.raw`\mathcal R_{BC}:\mathcal M_{BC}\to\mathcal M_{CB}`),
        " が、全ての ", math(String.raw`(b,c)\in B\times C`),
        " について一意な ", math(String.raw`(\widetilde c,\widetilde b)\in C\times B`),
        " と ", math(String.raw`H_{BC}(b,c)\in\mathbb Z`), " を用いて",
      ]),
      displayMath(String.raw`\operatorname{ev}_0\!\left(
  \mathcal R_{BC}(e_b\otimes e_c)
\right)
=z^{H_{BC}(b,c)}e_{\widetilde c}\otimes e_{\widetilde b}`),
      paragraph([
        "を満たし、対応 ",
        math(String.raw`R_{BC}(b,c):=(\widetilde c,\widetilde b)`),
        " が全単射であるとき、", math(String.raw`\mathcal R_{BC}`),
        " を結晶化抽出可能と呼ぶ。このとき部分写像",
      ]),
      displayMath(String.raw`\operatorname{Cry}(\mathcal R_{BC}):=(R_{BC},H_{BC})`),
      paragraph([
        "を結晶化抽出と呼ぶ。出力の ", math(String.raw`R_{BC}`), " は有限表、",
        math(String.raw`H_{BC}`), " は有限定義域上の整数値表である。",
        "入力の複素係数、", math(String.raw`q\ne0`), " での値、消える項、",
        math(String.raw`q,z`), " への依存は出力に含めない。",
      ]),
    ],
  },
  {
    id: "finite_combinatorial_scattering_data_claim_crystallization_not_injective",
    kind: "claim",
    title: { text: "結晶化抽出はスカラー規格化を復元しない" },
    labels: ["claim_crystallization_extraction_not_injective"],
    habitat: "mixed",
    realEscape:
      "結晶化前の異なる作用素族を比較するため複素係数の q 有理関数環を用いる。q=0 での代数的評価だけを使い、解析的極限や複素対数は用いない。",
    statement: [
      paragraph([
        ref("def_normalized_q_operator_crystallization_extraction"), " の結晶化抽出可能な ",
        math(String.raw`\mathcal R_{BC}`), " に対し",
      ]),
      displayMath(String.raw`\mathcal R_{BC}^{(0)}:=\mathcal R_{BC},
\qquad
\mathcal R_{BC}^{(1)}:=(1+q)\mathcal R_{BC}`),
      paragraph([
        "と置く。二つは異なる結晶化抽出可能な同型だが、",
      ]),
      displayMath(String.raw`\operatorname{Cry}(\mathcal R_{BC}^{(0)})
=\operatorname{Cry}(\mathcal R_{BC}^{(1)})`),
      paragraph([
        "である。従って結晶化抽出は単射でなく、有限内部散乱表と整数値表から結晶化前のスカラー規格化を一意に復元する逆写像は存在しない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`1+q\in\mathcal O_0`), " は単元であり、",
        math(String.raw`\operatorname{ev}_0(1+q)=1`), " である。任意の ",
        math(String.raw`(b,c)\in B\times C`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ev}_0\!\left(
  \mathcal R_{BC}^{(1)}(e_b\otimes e_c)
\right)
&=\operatorname{ev}_0(1+q)\,
  \operatorname{ev}_0\!\left(
    \mathcal R_{BC}(e_b\otimes e_c)
  \right)
  \quad(\because\ \operatorname{ev}_0\ \text{は環準同型})\\
&=\operatorname{ev}_0\!\left(
    \mathcal R_{BC}(e_b\otimes e_c)
  \right)
  \quad(\because\ \operatorname{ev}_0(1+q)=1).
\end{aligned}`),
      paragraph([
        ref("def_normalized_q_operator_crystallization_extraction"),
        " により、二つの入力から抽出される全単射と整数値表は一致する。",
        "一方、もし ", math(String.raw`\mathcal R_{BC}^{(1)}=\mathcal R_{BC}^{(0)}`),
        " なら、両辺の差を取って ", math(String.raw`q\mathcal R_{BC}=0`), " となる。",
        math(String.raw`\mathcal A_0`), " は整域で、",
        math(String.raw`q\ne0`), " かつ ", math(String.raw`\mathcal R_{BC}`),
        " は同型なので、これは不可能である。従って二つの入力は異なる。",
      ]),
    ],
  },
]);
