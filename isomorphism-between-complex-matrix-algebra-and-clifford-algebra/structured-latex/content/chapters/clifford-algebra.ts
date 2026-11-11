import { defineBlocks, displayMath, math, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "clifford_algebra_heading",
    kind: "heading",
    level: 1,
    title: { text: "クリフォード代数" },
    labels: [],
  },
  {
    id: "clifford_algebra_definition_clifford_ideal",
    kind: "definition",
    title: { text: "二次形式が定める、テンソル代数の両側イデアル" },
    labels: ["def_clifford_ideal"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）、", math(String.raw`q`), " を ",
        math(String.raw`V`), " 上の二次形式（", ref("def_quadratic_form"), "）とする。", math(String.raw`T(V)`), " を基底 ", math(String.raw`b`),
        " で構成した ", math(String.raw`V`), " のテンソル代数（", ref("def_vector_space_of_tensor_algebra"), "、", ref("claim_tensor_algebra_is_complex_algebra"),
        "）、", math(String.raw`\iota:V\to T(V)`), " を ", math(String.raw`V`), " からテンソル代数への埋め込み（",
        ref("def_embedding_of_vector_space_into_tensor_algebra"), "）とする。", math(String.raw`a\in\mathbb{C}`), " の加法の逆元を ",
        math(String.raw`-_{\mathbb{C}}a`), " と書く。",
      ]),
      paragraph([
        math(String.raw`T(V)`), " の部分集合 ", math(String.raw`I_q`), " を次で定め、", math(String.raw`q`), " が定める ", math(String.raw`T(V)`),
        " の両側イデアルと呼ぶ（", math(String.raw`\langle\ \rangle_{T(V)}`), " は部分集合が生成する両側イデアル。", ref("def_two_sided_ideal_generated_by_subset"), "）。",
      ]),
      displayMath(String.raw`I_q:=\Bigl\langle\,\Bigl\{\,\iota(v)\cdot_{T(V)}\iota(v)+_{T(V)}\bigl(\bigl(-_{\mathbb{C}}q(v)\bigr)\ast_{T(V)}1_{T(V)}\bigr)\ :\ v\in V\,\Bigr\}\,\Bigr\rangle_{T(V)}`),
      paragraph([
        math(String.raw`I_q`), " は ", math(String.raw`T(V)`), " の両側イデアル（", ref("def_two_sided_ideal"), "）である（",
        ref("claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal"), "）。", math(String.raw`T(V)`), " と ", math(String.raw`I_q`),
        " は基底 ", math(String.raw`b`), " の取り方にもよるが、記号には ", math(String.raw`b`), " を添えない。",
      ]),
    ],
  },
  {
    id: "clifford_algebra_definition_clifford_algebra",
    kind: "definition",
    title: { text: "クリフォード代数" },
    labels: ["def_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`T(V)`), "、", math(String.raw`I_q`), " を ", ref("def_clifford_ideal"),
        " のものとする。", math(String.raw`I_q`), " を法とする ", math(String.raw`T(V)`), " の商代数（", ref("claim_quotient_algebra_is_complex_algebra"),
        "）を ", math(String.raw`(V,q)`), " のクリフォード代数と呼び、次のように書く。",
      ]),
      displayMath(String.raw`\bigl(\mathrm{Cl}(V,q),+_{\mathrm{Cl}(V,q)},\cdot_{\mathrm{Cl}(V,q)},\ast_{\mathrm{Cl}(V,q)},0_{\mathrm{Cl}(V,q)},1_{\mathrm{Cl}(V,q)}\bigr):=\bigl(T(V)/I_q,+_{T(V)/I_q},\cdot_{T(V)/I_q},\ast_{T(V)/I_q},0_{T(V)/I_q},1_{T(V)/I_q}\bigr)`),
      paragraph([
        "これは ℂ-代数（", ref("def_complex_algebra"), "）である（", ref("claim_quotient_algebra_is_complex_algebra"), "）。",
        math(String.raw`\pi_{I_q}:T(V)\to\mathrm{Cl}(V,q)`), " を ", math(String.raw`I_q`), " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"), "）とする。", math(String.raw`\pi_{I_q}`), " は ℂ-代数の準同型である（",
        ref("claim_projection_onto_quotient_algebra_is_algebra_homomorphism"), "）。",
      ]),
    ],
  },
  {
    id: "clifford_algebra_definition_generator_map",
    kind: "definition",
    title: { text: "線型空間からクリフォード代数への写像" },
    labels: ["def_clifford_generator_map"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\iota`), " を ", ref("def_clifford_ideal"), " のもの、",
        math(String.raw`\mathrm{Cl}(V,q)`), " と ", math(String.raw`\pi_{I_q}`), " を ", ref("def_clifford_algebra"), " のものとする。写像 ",
        math(String.raw`\gamma:V\to\mathrm{Cl}(V,q)`), " を次で定める。",
      ]),
      displayMath(String.raw`\gamma(v):=\pi_{I_q}\bigl(\iota(v)\bigr)\qquad(v\in V)`),
      paragraph([
        math(String.raw`\gamma`), " の像を ", math(String.raw`\gamma(V):=\{\gamma(v):v\in V\}`), " と書く。", math(String.raw`V`), " は ",
        math(String.raw`\mathrm{Cl}(V,q)`), " の部分集合ではない。", math(String.raw`V`), " の元から ", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元を作るときは ", math(String.raw`\gamma`), " を通す。",
      ]),
    ],
  },
  {
    id: "clifford_algebra_claim_generator_map_is_linear_map",
    kind: "claim",
    title: { text: "線型空間からクリフォード代数への写像は線型写像である" },
    labels: ["claim_clifford_generator_map_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), " を ", ref("def_clifford_generator_map"),
        " のものとする。このとき ", math(String.raw`\gamma`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(\mathrm{Cl}(V,q))`), "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"), "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\iota`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(T(V))`), " への線型写像である（",
        ref("claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map"), "）。", math(String.raw`\pi_{I_q}`), " は ℂ-代数の準同型なので（",
        ref("claim_projection_onto_quotient_algebra_is_algebra_homomorphism"), "）、", math(String.raw`U_{\mathrm{vec}}(T(V))`), " から ",
        math(String.raw`U_{\mathrm{vec}}(\mathrm{Cl}(V,q))`), " への線型写像である（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）。",
        math(String.raw`\gamma=\pi_{I_q}\circ\iota`), "（", ref("def_clifford_generator_map"), "）は二つの線型写像の合成なので、線型写像である（",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）。",
      ]),
    ],
  },
  {
    id: "clifford_algebra_claim_square_of_generator",
    kind: "claim",
    title: { text: "線型空間の元の像の平方は、二次形式の値の単位元倍である" },
    labels: ["claim_square_of_clifford_generator"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), " を ",
        ref("def_clifford_generator_map"), " のものとする。このとき、すべての ", math(String.raw`v\in V`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\gamma(v)\cdot_{\mathrm{Cl}(V,q)}\gamma(v)=q(v)\ast_{\mathrm{Cl}(V,q)}1_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`x:=\iota(v)\cdot_{T(V)}\iota(v)\in T(V)`), "、", math(String.raw`\lambda:=q(v)\in\mathbb{C}`), " と置く。",
        math(String.raw`x+_{T(V)}\bigl((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)`), " は ", ref("def_clifford_ideal"),
        " で両側イデアルを生成する部分集合の元なので、", math(String.raw`I_q`), " の元である（", ref("claim_two_sided_ideal_generated_by_subset_contains_subset"),
        "）。以下、", math(String.raw`T(V)`), " の加法とスカラー倍についての等式は ", math(String.raw`U_{\mathrm{vec}}(T(V))`), " の公理（",
        ref("def_complex_vector_space"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma(v)\cdot_{\mathrm{Cl}(V,q)}\gamma(v)
&=\pi_{I_q}\bigl(\iota(v)\bigr)\cdot_{\mathrm{Cl}(V,q)}\pi_{I_q}\bigl(\iota(v)\bigr)
&&\left(\because\ \blkref{def_clifford_generator_map}\ \text{を二か所に適用}\right)\\
&=\pi_{I_q}(x)
&&\left(\because\ \pi_{I_q}\ \text{は乗法を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=\pi_{I_q}\bigl(x+_{T(V)}0_{T(V)}\bigr)
&&\left(\because\ 0_{T(V)}\ \text{は加法の単位元}\right)\\
&=\pi_{I_q}\bigl(x+_{T(V)}(0_{\mathbb{C}}\ast_{T(V)}1_{T(V)})\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\pi_{I_q}\Bigl(x+_{T(V)}\bigl((\lambda+_{\mathbb{C}}(-_{\mathbb{C}}\lambda))\ast_{T(V)}1_{T(V)}\bigr)\Bigr)
&&\left(\because\ -_{\mathbb{C}}\lambda\ \text{は}\ \lambda\ \text{の加法の逆元}\right)\\
&=\pi_{I_q}\Bigl(x+_{T(V)}\bigl(((-_{\mathbb{C}}\lambda)+_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\pi_{I_q}\Bigl(x+_{T(V)}\bigl(((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)})+_{T(V)}(\lambda\ast_{T(V)}1_{T(V)})\bigr)\Bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則}\right)\\
&=\pi_{I_q}\Bigl(\bigl(x+_{T(V)}((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)})\bigr)+_{T(V)}(\lambda\ast_{T(V)}1_{T(V)})\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&=\pi_{I_q}\bigl(x+_{T(V)}((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)})\bigr)+_{\mathrm{Cl}(V,q)}\pi_{I_q}\bigl(\lambda\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ \pi_{I_q}\ \text{は加法を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=0_{\mathrm{Cl}(V,q)}+_{\mathrm{Cl}(V,q)}\pi_{I_q}\bigl(\lambda\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ \text{第一項の元は}\ I_q\ \text{の元。}\blkref{claim_projection_onto_quotient_set_sends_ideal_elements_to_zero}\right)\\
&=\pi_{I_q}\bigl(\lambda\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ 0_{\mathrm{Cl}(V,q)}\ \text{は加法の単位元。}\blkref{def_complex_algebra}\right)\\
&=\lambda\ast_{\mathrm{Cl}(V,q)}\pi_{I_q}\bigl(1_{T(V)}\bigr)
&&\left(\because\ \pi_{I_q}\ \text{はスカラー倍を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=\lambda\ast_{\mathrm{Cl}(V,q)}1_{\mathrm{Cl}(V,q)}
&&\left(\because\ \pi_{I_q}\ \text{は乗法の単位元を保つ。}\blkref{claim_projection_onto_quotient_algebra_is_algebra_homomorphism}\text{、}\blkref{def_complex_algebra_homomorphism}\right)\\
&=q(v)\ast_{\mathrm{Cl}(V,q)}1_{\mathrm{Cl}(V,q)}
&&\left(\because\ \lambda\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "clifford_algebra_claim_image_of_generator_map_generates_clifford_algebra",
    kind: "claim",
    title: { text: "線型空間の像はクリフォード代数を生成する" },
    labels: ["claim_image_of_clifford_generator_map_generates_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{Cl}(V,q)`), " と ", math(String.raw`\gamma`), " を ", ref("def_clifford_generator_map"), " のものとする。このとき ",
        math(String.raw`\gamma(V)`), " は ", math(String.raw`\mathrm{Cl}(V,q)`), " を生成する（", ref("def_subset_generates_algebra"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B`), " を、", math(String.raw`\gamma(V)\subseteq B`), " を満たす ", math(String.raw`\mathrm{Cl}(V,q)`), " の部分代数（",
        ref("def_subalgebra"), "）とする。", math(String.raw`T(V)`), " の部分集合 ", math(String.raw`B'`), " を次で定める。",
      ]),
      displayMath(String.raw`B':=\bigl\{\,x\in T(V):\ \pi_{I_q}(x)\in B\,\bigr\}`),
      paragraph([
        math(String.raw`B'`), " が ", math(String.raw`T(V)`), " の部分代数の四条件を満たすことを示す。", math(String.raw`x,y`), " を ",
        math(String.raw`B'`), " の任意の元、", math(String.raw`\lambda`), " を ", math(String.raw`\mathbb{C}`), " の任意の元とする。",
        math(String.raw`\pi_{I_q}`), " が単位元・加法・乗法・スカラー倍を保つこと（", ref("claim_projection_onto_quotient_algebra_is_algebra_homomorphism"),
        "、", ref("def_complex_algebra_homomorphism"), "）と、", math(String.raw`B`), " が部分代数であることから、次の四つが成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_{I_q}\bigl(1_{T(V)}\bigr)&=1_{\mathrm{Cl}(V,q)}\in B,\\
\pi_{I_q}\bigl(x+_{T(V)}y\bigr)&=\pi_{I_q}(x)+_{\mathrm{Cl}(V,q)}\pi_{I_q}(y)\in B,\\
\pi_{I_q}\bigl(x\cdot_{T(V)}y\bigr)&=\pi_{I_q}(x)\cdot_{\mathrm{Cl}(V,q)}\pi_{I_q}(y)\in B,\\
\pi_{I_q}\bigl(\lambda\ast_{T(V)}x\bigr)&=\lambda\ast_{\mathrm{Cl}(V,q)}\pi_{I_q}(x)\in B.
\end{aligned}`),
      paragraph([
        "したがって ", math(String.raw`1_{T(V)}`), "、", math(String.raw`x+_{T(V)}y`), "、", math(String.raw`x\cdot_{T(V)}y`), "、",
        math(String.raw`\lambda\ast_{T(V)}x`), " は ", math(String.raw`B'`), " の元であり、", math(String.raw`B'`), " は ", math(String.raw`T(V)`),
        " の部分代数である（", ref("def_subalgebra"), "）。",
      ]),
      paragraph([
        "任意の ", math(String.raw`v\in V`), " について ", math(String.raw`\pi_{I_q}(\iota(v))=\gamma(v)\in B`), " なので（", ref("def_clifford_generator_map"),
        "）、", math(String.raw`\iota(V)\subseteq B'`), " である。", math(String.raw`\iota(V)`), " は ", math(String.raw`T(V)`), " を生成するので（",
        ref("claim_image_of_embedding_generates_tensor_algebra"), "）、", math(String.raw`B'=T(V)`), " である（", ref("def_subset_generates_algebra"), "）。",
      ]),
      paragraph([
        math(String.raw`X`), " を ", math(String.raw`\mathrm{Cl}(V,q)`), " の任意の元とする。射影は全射なので（", ref("claim_projection_onto_quotient_set_is_surjective"),
        "）、", math(String.raw`\pi_{I_q}(a)=X`), " を満たす ", math(String.raw`a\in T(V)`), " がある。", math(String.raw`a\in T(V)=B'`), " なので ",
        math(String.raw`X=\pi_{I_q}(a)\in B`), " である。したがって ", math(String.raw`\mathrm{Cl}(V,q)\subseteq B`), " であり、", math(String.raw`B\subseteq\mathrm{Cl}(V,q)`),
        " と合わせて ", math(String.raw`B=\mathrm{Cl}(V,q)`), " である。", math(String.raw`B`), " は任意だったので、", math(String.raw`\gamma(V)`), " は ",
        math(String.raw`\mathrm{Cl}(V,q)`), " を生成する（", ref("def_subset_generates_algebra"), "）。",
      ]),
    ],
  },
  {
    id: "clifford_algebra_claim_universal_property",
    kind: "claim",
    title: { text: "クリフォード代数の普遍性" },
    labels: ["claim_universal_property_of_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), " を ",
        ref("def_clifford_generator_map"), " のもの、", math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"),
        "）、", math(String.raw`f:V\to A`), " を ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像（", ref("def_linear_map"),
        "）とし、すべての ", math(String.raw`v\in V`), " について次が成り立つとする。",
      ]),
      displayMath(String.raw`f(v)\cdot_A f(v)=q(v)\ast_A 1_A`),
      paragraph([
        "このとき、", math(String.raw`\mathrm{Cl}(V,q)`), " から ", math(String.raw`A`), " への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）",
        math(String.raw`\Phi`), " で ", math(String.raw`\Phi\circ\gamma=f`), " を満たすものが、ただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "（存在）テンソル代数の普遍性（", ref("claim_universal_property_of_tensor_algebra"), "）により、", math(String.raw`T(V)`), " から ",
        math(String.raw`A`), " への ℂ-代数の準同型 ", math(String.raw`F`), " で ", math(String.raw`F\circ\iota=f`), " を満たすものがある。",
        math(String.raw`v\in V`), " を任意に取り、", math(String.raw`\lambda:=q(v)\in\mathbb{C}`), " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
&F\Bigl(\iota(v)\cdot_{T(V)}\iota(v)+_{T(V)}\bigl((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)\Bigr)\\
&\quad=F\bigl(\iota(v)\cdot_{T(V)}\iota(v)\bigr)+_A F\bigl((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ F\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\Bigl(F\bigl(\iota(v)\bigr)\cdot_A F\bigl(\iota(v)\bigr)\Bigr)+_A F\bigl((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ F\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\bigl(f(v)\cdot_A f(v)\bigr)+_A F\bigl((-_{\mathbb{C}}\lambda)\ast_{T(V)}1_{T(V)}\bigr)
&&\left(\because\ F\circ\iota=f\ \text{を二か所に適用}\right)\\
&\quad=\bigl(f(v)\cdot_A f(v)\bigr)+_A\Bigl((-_{\mathbb{C}}\lambda)\ast_A F\bigl(1_{T(V)}\bigr)\Bigr)
&&\left(\because\ F\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\bigl(f(v)\cdot_A f(v)\bigr)+_A\bigl((-_{\mathbb{C}}\lambda)\ast_A 1_A\bigr)
&&\left(\because\ F\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\bigl(\lambda\ast_A 1_A\bigr)+_A\bigl((-_{\mathbb{C}}\lambda)\ast_A 1_A\bigr)
&&\left(\because\ f\ \text{についての仮定と}\ \lambda\ \text{の定義}\right)\\
&\quad=\bigl(\lambda+_{\mathbb{C}}(-_{\mathbb{C}}\lambda)\bigr)\ast_A 1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&\quad=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ -_{\mathbb{C}}\lambda\ \text{は}\ \lambda\ \text{の加法の逆元}\right)\\
&\quad=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "したがって、", ref("def_clifford_ideal"), " で ", math(String.raw`I_q`), " を生成する部分集合は、", math(String.raw`K_F:=\{x\in T(V):F(x)=0_A\}`),
        " に含まれる。", math(String.raw`K_F`), " は ", math(String.raw`T(V)`), " の両側イデアルなので（", ref("claim_kernel_of_algebra_homomorphism_is_two_sided_ideal"),
        "）、", math(String.raw`I_q\subseteq K_F`), " である（", ref("claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset"),
        "）。すなわち ", math(String.raw`I_q`), " の任意の元 ", math(String.raw`x`), " について ", math(String.raw`F(x)=0_A`), " である。",
      ]),
      paragraph([
        math(String.raw`\overline{F}:\mathrm{Cl}(V,q)\to A`), " を、", math(String.raw`F`), " が ", math(String.raw`I_q`), " を法とする商代数の上に誘導する写像（",
        ref("def_map_induced_on_quotient_algebra"), "）とする。", math(String.raw`\overline{F}`), " は ℂ-代数の準同型である（", ref("claim_induced_map_is_algebra_homomorphism"),
        "）。任意の ", math(String.raw`v\in V`), " について次が成り立つので、", math(String.raw`\overline{F}\circ\gamma=f`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{F}\bigl(\gamma(v)\bigr)
&=\overline{F}\Bigl(\pi_{I_q}\bigl(\iota(v)\bigr)\Bigr)
&&\left(\because\ \blkref{def_clifford_generator_map}\right)\\
&=F\bigl(\iota(v)\bigr)
&&\left(\because\ \overline{F}\circ\pi_{I_q}=F\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=f(v)
&&\left(\because\ F\circ\iota=f\right).
\end{aligned}`),
      paragraph([
        "（一意性）", math(String.raw`\Phi,\Phi'`), " を、", math(String.raw`\Phi\circ\gamma=f`), "、", math(String.raw`\Phi'\circ\gamma=f`),
        " を満たす ", math(String.raw`\mathrm{Cl}(V,q)`), " から ", math(String.raw`A`), " への ℂ-代数の準同型とする。", math(String.raw`\gamma(V)`),
        " の任意の元は ", math(String.raw`v\in V`), " によって ", math(String.raw`\gamma(v)`), " と書け、", math(String.raw`\Phi(\gamma(v))=f(v)=\Phi'(\gamma(v))`),
        " である。", math(String.raw`\gamma(V)`), " は ", math(String.raw`\mathrm{Cl}(V,q)`), " を生成するので（",
        ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）、", ref("claim_homomorphisms_agreeing_on_generators_are_equal"),
        " により ", math(String.raw`\Phi=\Phi'`), " である。",
      ]),
    ],
  },
]);
