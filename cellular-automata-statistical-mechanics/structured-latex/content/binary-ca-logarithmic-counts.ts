import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "binary_ca_logarithmic_counts_definition_integer_observable",
    kind: "definition",
    title: { text: "有限舞台の整数値保存写像" },
    labels: ["def_binary_ca_integer_conserved_observable"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_finite_ca"), " の有限舞台の大域写像 ", math(String.raw`F:A^V\to A^V`),
        " に対して、写像 ", math(String.raw`H:A^V\to\mathbb Z`), " が"]),
      displayMath(String.raw`\forall x\in A^V,\qquad H(Fx)=H(x)`),
      paragraph(["を満たすとき整数値保存写像と呼ぶ。入力として有限表を与え、全配位でこの等号を判定する。",
        "定数写像も許す。局所的な和の形、非定数性、単位の選び方は仮定しない。",
        "保存写像は局所規則に追加の意味を与えるものではなく、既に与えた大域写像について検査する写像である。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_fibers",
    kind: "definition",
    title: { text: "保存写像の値で分けた反復不動点集合" },
    labels: ["def_binary_ca_fixed_point_fibers"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_binary_ca_integer_conserved_observable"), " の ", math(String.raw`F,H`),
        " と ", math(String.raw`n\in\mathbb N_{>0}`), "、", math(String.raw`u\in\mathbb Z`), " に対し、"]),
      displayMath(String.raw`C_{F,H,n}(u):=\{x\in\mathrm{Fix}_n(F):H(x)=u\}\subseteq A^V`),
      paragraph(["と定める。", math(String.raw`\mathrm{Fix}_n(F)`), " は ", ref("def_fixed_points_of_iterate"),
        " による。これは有限集合であり、空の場合も含む。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_multiplicity",
    kind: "definition",
    title: { text: "反復不動点の繊維ごとの状態数" },
    labels: ["def_binary_ca_fiber_multiplicity"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "N",
    statement: [
      paragraph([ref("def_binary_ca_fixed_point_fibers"), " の入力に対し、状態数を"]),
      displayMath(String.raw`\Omega_{F,H}:\mathbb N_{>0}\times\mathbb Z\longrightarrow\mathbb N,\qquad
\Omega_{F,H}(n,u):=|C_{F,H,n}(u)|`),
      paragraph(["と定める。零個の場合にも定義される。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_positive_levels",
    kind: "definition",
    title: { text: "正の状態数を持つ整数値の有限集合" },
    labels: ["def_binary_ca_positive_fiber_levels"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_binary_ca_fiber_multiplicity"), " の ", math(String.raw`F,H,n`), " に対し、"]),
      displayMath(String.raw`D_{F,H,n}:=\{u\in\mathbb Z:\Omega_{F,H}(n,u)>0\}`),
      paragraph(["と定める。有限集合の正の元数と非空性、および ", ref("def_binary_ca_fixed_point_fibers"),
        " から ", math(String.raw`D_{F,H,n}=H(\mathrm{Fix}_n(F))`),
        " であり有限である。ここで像は ", math(String.raw`H(E):=\{H(x):x\in E\}`), " を意味する。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_claim_partition_count",
    kind: "claim",
    title: { text: "繊維ごとの状態数の総和は反復不動点数である" },
    labels: ["claim_binary_ca_fiber_count_partition"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "N",
    statement: [
      paragraph([ref("def_binary_ca_positive_fiber_levels"), " の有限集合を用いると、各 ",
        math(String.raw`n\in\mathbb N_{>0}`), " について"]),
      displayMath(String.raw`\sum_{u\in D_{F,H,n}}\Omega_{F,H}(n,u)=Z_n(F)`),
      paragraph(["が成り立つ。右辺は ", ref("def_fixed_points_of_iterate"), " による。空和は零とする。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`x\in\mathrm{Fix}_n(F)`), " は ",
        math(String.raw`u:=H(x)\in D_{F,H,n}`), " の繊維に属する（",
        ref("def_binary_ca_positive_fiber_levels"), "、", ref("def_binary_ca_fixed_point_fibers"),
        "）。また二つの繊維の共通元があれば、その元における ", math(String.raw`H`),
        " の値が二つの添字に等しいため添字は一致する。従って繊維は互いに交わらず、不動点集合を覆う。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{u\in D_{F,H,n}}\Omega_{F,H}(n,u)
&=\sum_{u\in D_{F,H,n}}|C_{F,H,n}(u)|\quad(\because\ \blkref{def_binary_ca_fiber_multiplicity})\\
&=\left|\bigcup_{u\in D_{F,H,n}}C_{F,H,n}(u)\right|\quad(\because\ \text{有限な互いに素な合併の元数})\\
&=|\mathrm{Fix}_n(F)|\quad(\because\ \text{上の被覆})\\
&=Z_n(F)\quad(\because\ \blkref{def_fixed_points_of_iterate}).
\end{aligned}`),
      paragraph(["不動点集合が空なら像も空で、同じ等式の両辺が零になる。保存条件はこの数え上げには使わず、任意の整数値写像でも成り立つ。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_entropy",
    kind: "definition",
    title: { text: "正の繊維状態数の対数順序群値エントロピー" },
    labels: ["def_binary_ca_fiber_logarithmic_entropy"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_binary_ca_positive_fiber_levels"), " の定義域に限って、", ref("def_prime_logarithm"), " を用い"]),
      displayMath(String.raw`S_{F,H}:\{(n,u):n\in\mathbb N_{>0},\ u\in D_{F,H,n}\}\longrightarrow\Lambda,\qquad
S_{F,H}(n,u):=\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,u)}1\right)`),
      paragraph(["と定める。分数は正の自然数の個数から正の有理数へ渡す写像である。状態数が零の入力には値を与えない。",
        "この節でエントロピーという名前が指すのは、この数え上げの対数だけである。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_unit_difference",
    kind: "definition",
    title: { text: "隣接する整数値でのエントロピー差" },
    labels: ["def_binary_ca_unit_logarithmic_difference"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_binary_ca_fiber_logarithmic_entropy"), " と ", ref("def_prime_vector_additive_operations"),
        " を用いて、", math(String.raw`n\in\mathbb N_{>0}`), "、", math(String.raw`u,u+1\in D_{F,H,n}`), " の場合に限り、"]),
      displayMath(String.raw`\beta_{F,H}(n,u):=S_{F,H}(n,u+1)-_\Lambda S_{F,H}(n,u)\in\Lambda`),
      paragraph(["と定める。逆温度に当たる候補として構成する量は、この整数刻み 1 の差である。",
        "定義域は空でもよく、別の整数刻みへ同じ除算が使えるとは仮定しない。",
        "整数値写像の取り方に依存するので、大域写像だけから一意に定まる量とは主張しない。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_claim_unit_ratio",
    kind: "claim",
    title: { text: "隣接差は二つの正の状態数の比の対数である" },
    labels: ["claim_binary_ca_unit_difference_ratio"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_binary_ca_unit_logarithmic_difference"), " の定義域では"]),
      displayMath(String.raw`\beta_{F,H}(n,u)=\log_\Lambda\!\left(
\frac{\Omega_{F,H}(n,u+1)}{\Omega_{F,H}(n,u)}\right)`),
      paragraph(["が成り立つ。右辺の比は正の有理数であり、実数への評価は要らない。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\beta_{F,H}(n,u)&=S_{F,H}(n,u+1)-_\Lambda S_{F,H}(n,u)
  \quad(\because\ \blkref{def_binary_ca_unit_logarithmic_difference})\\
&=\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,u+1)}1\right)
  -_\Lambda\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,u)}1\right)
  \quad(\because\ \blkref{def_binary_ca_fiber_logarithmic_entropy})\\
&=\log_\Lambda\!\left(
  \frac{\Omega_{F,H}(n,u+1)/1}{\Omega_{F,H}(n,u)/1}\right)
  \quad(\because\ \blkref{claim_prime_logarithm_ratio})\\
&=\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,u+1)}{\Omega_{F,H}(n,u)}\right)
  \quad(\because\ \mathbb Q_{>0}\text{ の除算}).
\end{aligned}`),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_definition_free_count",
    kind: "definition",
    title: { text: "正の反復不動点数の対数順序群値自由エントロピー" },
    labels: ["def_binary_ca_logarithmic_free_count"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph(["有限舞台の大域写像 ", math(String.raw`F:A^V\to A^V`), " に対して、",
        ref("def_positive_fixed_point_count_rational_input"), " の写像 ", math(String.raw`q_F`), " を経由して"]),
      displayMath(String.raw`\Phi_F:\mathsf{Pos}_F\longrightarrow\Lambda,\qquad
\Phi_F(n):=\log_\Lambda(q_F(n))`),
      paragraph(["と定める。対数は ", ref("def_prime_logarithm"), " による。この自由エントロピーは重みを付けない不動点の総数を対象とし、",
        "正の回数で個数が零なら定義しない。保存写像の選択には依存しない。",
        "任意の重みを導入した分配関数や、回数・セル数による規格化はこの定義に含めない。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_claim_free_count_bound",
    kind: "claim",
    title: { text: "有限舞台の自由エントロピーは配位の総数の対数以下である" },
    labels: ["claim_binary_ca_logarithmic_free_count_bound"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_binary_ca_logarithmic_free_count"), " の定義域 ", math(String.raw`n\in\mathsf{Pos}_F`), " では"]),
      displayMath(String.raw`0_\Lambda\le_\Lambda\Phi_F(n)\le_\Lambda
\log_\Lambda\!\left(\frac{2^{|V|}}1\right)`),
      paragraph(["である。順序は ", ref("def_prime_vector_order"), " による。固定した有限舞台で回数を変えてもこの上界は変わらない。"]),
    ],
    proof: [
      paragraph([ref("def_positive_fixed_point_count_domain"), " により ", math(String.raw`Z_n(F)\ge1`),
        "。", ref("claim_binary_ca_fixed_point_count_bound"), " により ", math(String.raw`Z_n(F)\le2^{|V|}`),
        "。自然数から分母 1 の有理数への写像は順序を保つので、"]),
      displayMath(String.raw`1\le q_F(n)\le\frac{2^{|V|}}1
\quad(\because\ \blkref{def_positive_fixed_point_count_rational_input}).`),
      paragraph([ref("claim_prime_logarithm_ordered_group"), " を両不等式へ適用する。",
        ref("def_prime_logarithm"), " の全係数が 1 で零なので ", math(String.raw`\log_\Lambda1=0_\Lambda`),
        "、中央の量は ", ref("def_binary_ca_logarithmic_free_count"), " による。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_claim_free_count_fibers",
    kind: "claim",
    title: { text: "自由エントロピーは繊維状態数の有限和の対数である" },
    labels: ["claim_binary_ca_logarithmic_free_count_fibers"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_binary_ca_integer_conserved_observable"), " の ", math(String.raw`F,H`),
        " と ", math(String.raw`n\in\mathsf{Pos}_F`), " に対し、"]),
      displayMath(String.raw`\Phi_F(n)=\log_\Lambda\!\left(
\frac{\sum_{u\in D_{F,H,n}}\Omega_{F,H}(n,u)}1\right)`),
      paragraph(["が成り立つ。左辺は ", ref("def_binary_ca_logarithmic_free_count"),
        "、右辺の和は ", ref("def_binary_ca_positive_fiber_levels"), " による。繊維の対数の和に置き換える等式ではない。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\Phi_F(n)&=\log_\Lambda(q_F(n))\quad(\because\ \blkref{def_binary_ca_logarithmic_free_count})\\
&=\log_\Lambda\!\left(\frac{Z_n(F)}1\right)\quad(\because\ \blkref{def_positive_fixed_point_count_rational_input})\\
&=\log_\Lambda\!\left(\frac{\sum_{u\in D_{F,H,n}}\Omega_{F,H}(n,u)}1\right)
  \quad(\because\ \blkref{claim_binary_ca_fiber_count_partition}).
\end{aligned}`),
      paragraph(["和は正の ", math(String.raw`Z_n(F)`), " に等しいので、対数の入力条件を満たす。"]),
    ],
  },
  {
    id: "binary_ca_logarithmic_counts_claim_gap_division_obstruction",
    kind: "claim",
    title: { text: "二セルの恒等規則でも刻み二のエントロピー差を群内で割れない" },
    labels: ["claim_binary_ca_logarithmic_gap_division_obstruction"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph(["セル集合 ", math(String.raw`V:=\{v,w\}`), "（", math(String.raw`v\ne w`),
        "）、自己近傍 ", math(String.raw`N(v)=\{v\},N(w)=\{w\}`),
        "、局所規則 ", math(String.raw`f_z(y):=y(z)`), "（", math(String.raw`z\in V`),
        "、", math(String.raw`y\in A^{\{z\}}`), "）を与える。", ref("def_global_map"),
        " の大域写像を ", math(String.raw`F`), " とする。配位 ", math(String.raw`x_{ab}`),
        " を ", math(String.raw`x_{ab}(v)=a,x_{ab}(w)=b`), "（", math(String.raw`a,b\in A`), "）で表し、"]),
      displayMath(String.raw`H(x_{00})=0,\qquad H(x_{01})=H(x_{10})=2,\qquad H(x_{11})=4`),
      paragraph(["という整数値写像を与える。この ", math(String.raw`H`), " は ",
        ref("def_binary_ca_integer_conserved_observable"), " の保存写像であるが、各 ",
        math(String.raw`n\in\mathbb N_{>0}`), " において"]),
      displayMath(String.raw`\nexists b\in\Lambda:\quad
2\cdot_\Lambda b=S_{F,H}(n,2)-_\Lambda S_{F,H}(n,0)`),
      paragraph(["となる。", math(String.raw`S`), " は ", ref("def_binary_ca_fiber_logarithmic_entropy"),
        " による。この例は、両端の状態数が正であっても非単位刻みの差分商が群の中にあるとは限らないことを示す。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`x\in A^V`), "、", math(String.raw`z\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(Fx)(z)&=f_z(x|_{\{z\}})\quad(\because\ \blkref{def_global_map})\\
&=(x|_{\{z\}})(z)\quad(\because\ \text{与えた局所規則})\\
&=x(z)\quad(\because\ \blkref{def_restriction_map}).
\end{aligned}`),
      paragraph(["写像の外延性で ", math(String.raw`Fx=x`), "。従って ", math(String.raw`H(Fx)=H(x)`),
        " である。", math(String.raw`F^n x=x`), " を自然数の帰納法で示す。基底は ",
        ref("def_finite_self_map_iterate"), " による恒等写像であり、帰納段階は"]),
      displayMath(String.raw`\begin{aligned}
F^{n+1}x&=F(F^n x)\quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F(x)\quad(\because\ \text{帰納法の仮定})\\
&=x\quad(\because\ \text{上の局所規則の計算}).
\end{aligned}`),
      paragraph([ref("def_fixed_points_of_iterate"), " により ", math(String.raw`\mathrm{Fix}_n(F)=A^V`),
        "。全配位は上の四つだけであり、", ref("def_binary_ca_fixed_point_fibers"), " の繊維は"]),
      displayMath(String.raw`C_{F,H,n}(0)=\{x_{00}\},\qquad
C_{F,H,n}(2)=\{x_{01},x_{10}\},\qquad C_{F,H,n}(4)=\{x_{11}\}.`),
      paragraph(["その他の繊維は空である。", ref("def_binary_ca_fiber_multiplicity"),
        " より状態数は順に 1,2,1。", ref("def_binary_ca_positive_fiber_levels"), " より ",
        math(String.raw`D_{F,H,n}=\{0,2,4\}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
S_{F,H}(n,2)-_\Lambda S_{F,H}(n,0)
&=\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,2)}1\right)
  -_\Lambda\log_\Lambda\!\left(\frac{\Omega_{F,H}(n,0)}1\right)
  \quad(\because\ \blkref{def_binary_ca_fiber_logarithmic_entropy})\\
&=\log_\Lambda(2/1)-_\Lambda\log_\Lambda(1/1)\quad(\because\ \text{上で数えた繊維の元数})\\
&=\log_\Lambda((2/1)/(1/1))\quad(\because\ \blkref{claim_prime_logarithm_ratio})\\
&=\log_\Lambda(2/1)\quad(\because\ \mathbb Q_{>0}\text{ の算術}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(\log_\Lambda(2/1))(2)&=v_2(2/1)\quad(\because\ \blkref{def_prime_logarithm})\\
&=1\quad(\because\ \blkref{def_positive_rational_prime_valuation}\text{ と }2\text{ の素因数分解}).
\end{aligned}`),
      paragraph(["整数 2 は整数 1 を割らないので、", ref("claim_prime_vector_integer_division"),
        " により解は存在しない。またこの例では隣接する二整数が ", math(String.raw`D_{F,H,n}`),
        " に無いため、", ref("def_binary_ca_unit_logarithmic_difference"), " の定義域も空である。",
        "保存写像の値を付け替えて単位刻みを選ぶ操作は、入力写像を変えることであり、この除算を正当化しない。"]),
    ],
  },
]);
