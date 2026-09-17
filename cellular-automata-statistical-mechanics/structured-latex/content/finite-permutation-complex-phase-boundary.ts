/**
 * 有限可逆大域写像から整数置換行列・巡回型・有限位相符号を内在的に構成し、
 * 複素固有値と実数値位相生成子へ移る比較写像および持ち上げの非一意性を分離する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_permutation_complex_phase_boundary_definition_permutation_matrix",
    kind: "definition",
    title: { text: "有限可逆大域写像の整数置換行列" },
    labels: ["def_binary_ca_reversible_global_permutation_matrix"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_finite_ca"), " の有限舞台上の 2 値セルオートマトンについて、",
        math(String.raw`X:=A^V`), " と置き、大域写像 ", math(String.raw`F:X\to X`),
        " が全単射であるとする。行と列を ", math(String.raw`X`), " で添字づけた整数行列 ",
        math(String.raw`P_F\in\mathbb Z^{X\times X}`), " を",
      ]),
      displayMath(String.raw`P_F(y,x):=
\begin{cases}
  1,&y=F(x),\\
  0,&y\neq F(x)
\end{cases}
\qquad(x,y\in X)`),
      paragraph([
        "と定める。これは有限真理値表から定まる大域写像の有限表を、整数 ",
        math(String.raw`0,1`), " だけで行列へ移す写像であり、複素数体を用いない。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_claim_matrix_powers",
    kind: "claim",
    title: { text: "置換行列の冪は有限時間発展を記録する" },
    labels: ["claim_binary_ca_permutation_matrix_powers_encode_iterates"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_global_permutation_matrix"), " の任意の ",
        math(String.raw`n\in\mathbb N`), " と ", math(String.raw`x,y\in X`), " について",
      ]),
      displayMath(String.raw`P_F^n(y,x)=
\begin{cases}
  1,&y=F^n(x),\\
  0,&y\neq F^n(x)
\end{cases}`),
      paragraph(["が成り立つ。従って整数置換行列の冪は有限回の時間発展だけを記録する。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n=0`), " では ", math(String.raw`P_F^0=I_X`),
        " と恒等写像の表が一致する。主張が ", math(String.raw`n`), " で成り立つと仮定する。行列積の定義により",
      ]),
      displayMath(String.raw`P_F^{n+1}(y,x)
=\sum_{z\in X}P_F(y,z)P_F^n(z,x)
\qquad(\because\ \text{行列積の定義})`),
      paragraph([
        ref("def_binary_ca_reversible_global_permutation_matrix"), " と帰納法の仮定により、和の項が ",
        math(String.raw`1`), " になるのは ", math(String.raw`z=F^n(x)`), " かつ ",
        math(String.raw`y=F(z)`), " の場合だけである。この条件は ",
        math(String.raw`y=F^{n+1}(x)`), " と同値なので帰納法が閉じる。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_finite_order",
    kind: "definition",
    title: { text: "有限可逆時間発展の位数" },
    labels: ["def_binary_ca_reversible_global_finite_order"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_global_permutation_matrix"), " の有限二値配位空間 ",
        math(String.raw`X=A^V`), " 上の大域写像について、",
        ref("def_reversible_cycle_type"), " の周期軌道全体を ", math(String.raw`\mathcal O_F`),
        " とする。各軌道の正の元数の最小公倍数",
      ]),
      displayMath(String.raw`L_F:=\operatorname{lcm}\{\,|O|:O\in\mathcal O_F\,\}\in\mathbb N_{>0}`),
      paragraph([
        "を有限可逆時間発展の位数と呼ぶ。", math(String.raw`X=A^V`),
        " は空でなく、", ref("claim_bijective_self_map_orbits_partition_carrier"),
        " により ", math(String.raw`\mathcal O_F`), " は空でない有限集合なので、この最小公倍数は定義される。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_claim_finite_order",
    kind: "claim",
    title: { text: "有限位数で時間発展と置換行列が恒等化する" },
    labels: ["claim_binary_ca_reversible_global_finite_order_identity"],
    habitat: "Z",
    statement: [
      paragraph([ref("def_binary_ca_reversible_global_finite_order"), " の ", math(String.raw`L_F`), " について"]),
      displayMath(String.raw`F^{L_F}=\operatorname{id}_X,\qquad P_F^{L_F}=I_X`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("claim_bijective_self_map_orbits_partition_carrier"), " により任意の ",
        math(String.raw`x\in X`), " は唯一の軌道 ", math(String.raw`O\in\mathcal O_F`),
        " に属する。", ref("claim_periodic_orbit_card_eq_min_period"), " により ",
        math(String.raw`|O|`), " は ", math(String.raw`x`), " の最小周期であり、",
        ref("def_binary_ca_reversible_global_finite_order"), " により ", math(String.raw`|O|\mid L_F`),
        " である。従って周期の正整数倍でも ", math(String.raw`F^{L_F}(x)=x`),
        " となり、第一の等式を得る。第二の等式は第一の等式を ",
        ref("claim_binary_ca_permutation_matrix_powers_encode_iterates"), " へ代入して得る。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_phase_codes",
    kind: "definition",
    title: { text: "周期軌道の有限位相符号" },
    labels: ["def_binary_ca_reversible_phase_codes"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_binary_ca_reversible_global_finite_order"), " の周期軌道ごとに有限集合"]),
      displayMath(String.raw`C_O:=\{\,k\in\mathbb N:k<|O|\,\}`),
      paragraph(["を置き、有限位相符号全体を"]),
      displayMath(String.raw`\operatorname{Ph}(F):=\{\,(O,k):O\in\mathcal O_F,\ k\in C_O\,\}`),
      paragraph([
        "と定める。これは周期軌道とその中の有限剰余位置だけからなる有限集合であり、",
        "円周、複素数、角度、時間尺度をまだ仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_complex_realization",
    kind: "definition",
    title: { text: "有限位相符号の複素実現" },
    labels: ["def_binary_ca_reversible_phase_complex_realization"],
    habitat: "C",
    realEscape:
      "有限位相符号を複素固有値と比較するため、実円周定数、整数と自然数の標準実数像、複素単位および複素指数関数を選ぶ。極限、無限和、複素対数は使わない。",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_phase_codes"), " の位相符号に対し、実円周定数 ",
        math(String.raw`\pi_{\mathbb R}\in\mathbb R_{>0}`), "、複素単位 ",
        math(String.raw`\mathrm i\in\mathbb C`), "、複素指数写像 ",
        math(String.raw`\exp_{\mathbb C}:\mathbb C\to\mathbb C`), " を用いて",
      ]),
      displayMath(String.raw`\rho_F(O,k):=
\exp_{\mathbb C}\!\left(
  2\pi_{\mathbb R}\mathrm i\,\frac{k}{|O|}
\right)\in\mathbb C`),
      paragraph([
        "と定める。分数では ", math(String.raw`k,|O|`),
        " を標準単射で実数へ送ってから実数除算を行う。これは有限符号から複素数への比較写像であり、",
        "両者を同一視しない。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_complex_action",
    kind: "definition",
    title: { text: "整数置換行列の複素係数作用" },
    labels: ["def_binary_ca_permutation_matrix_complex_action"],
    habitat: "C",
    realEscape:
      "整数置換行列の固有値を述べる比較対象を作るため、整数の複素数への標準単射と複素数値関数の有限和を用いる。",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_global_permutation_matrix"), " の整数行列と標準単射 ",
        math(String.raw`\iota_{\mathbb C}:\mathbb Z\hookrightarrow\mathbb C`), " に対し、",
        math(String.raw`z:X\to\mathbb C`), " への作用を",
      ]),
      displayMath(String.raw`(P_F^{\mathbb C}z)(y):=
\sum_{x\in X}\iota_{\mathbb C}\!\left(P_F(y,x)\right)z(x)
=z\!\left(F^{-1}(y)\right)`),
      paragraph([
        "と定める。最後の等号は各行で ", math(String.raw`x=F^{-1}(y)`),
        " の項だけが一になることによる有限和の等式である。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_orbit_phase_vector",
    kind: "definition",
    title: { text: "周期軌道に支えられた複素位相ベクトル" },
    labels: ["def_binary_ca_orbit_complex_phase_vector"],
    habitat: "C",
    realEscape:
      "有限位相符号を置換行列の複素固有ベクトルとして実現するため、複素位相比較写像の有限冪を用いる。",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_phase_codes"), " の有限二値配位空間 ",
        math(String.raw`X=A^V`), " 上で、", math(String.raw`O\in\mathcal O_F`),
        " ごとに基点 ", math(String.raw`q_O\in O`),
        " を一つ選ぶ。", math(String.raw`k\in C_O`), " に対し ",
        math(String.raw`u_{O,k}:X\to\mathbb C`), " を",
      ]),
      displayMath(String.raw`u_{O,k}\!\left(F^j(q_O)\right):=\rho_F(O,k)^{-j}
\quad(0\le j<|O|),\qquad
u_{O,k}(x):=0\quad(x\notin O)`),
      paragraph([
        "と定める。", ref("claim_periodic_orbit_card_eq_min_period"),
        " により ", math(String.raw`0\le j<|O|`),
        " の表示は一意なので、この関数は well-defined である。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_claim_eigenpair",
    kind: "claim",
    title: { text: "有限位相符号は複素固有対を与える" },
    labels: ["claim_binary_ca_phase_code_realizes_complex_eigenpair"],
    habitat: "C",
    realEscape:
      "有限位相符号の複素実現と、整数置換行列を複素係数関数へ作用させる比較写像を用いて固有対を述べる。",
    statement: [
      paragraph([
        "任意の ", math(String.raw`(O,k)\in\operatorname{Ph}(F)`), " について ",
        math(String.raw`u_{O,k}`), " は零関数でなく、",
      ]),
      displayMath(String.raw`P_F^{\mathbb C}u_{O,k}=\rho_F(O,k)u_{O,k},
\qquad \rho_F(O,k)^{|O|}=1`),
      paragraph(["が成り立つ。従って有限位相符号の複素実現は置換行列の固有値を与える。"]),
    ],
    proof: [
      paragraph([
        ref("def_binary_ca_reversible_phase_complex_realization"), " と複素指数関数の加法則から",
      ]),
      displayMath(String.raw`\rho_F(O,k)^{|O|}
=\exp_{\mathbb C}(2\pi_{\mathbb R}\mathrm i k)
=1`),
      paragraph([
        ref("def_binary_ca_orbit_complex_phase_vector"), " により ",
        math(String.raw`u_{O,k}(q_O)=1`), " なので零関数ではない。任意の ",
        math(String.raw`y\in O`), " を ", math(String.raw`y=F^j(q_O)`),
        " と巡回添字で書くと、",
      ]),
      displayMath(String.raw`\begin{aligned}
(P_F^{\mathbb C}u_{O,k})(y)
&=u_{O,k}(F^{-1}(y))
  \quad(\because\ \blkref{def_binary_ca_permutation_matrix_complex_action})\\
&=\rho_F(O,k)\,u_{O,k}(y)
  \quad(\because\ \blkref{def_binary_ca_orbit_complex_phase_vector}\ \text{と}\ \rho_F(O,k)^{|O|}=1).
\end{aligned}`),
      paragraph([
        math(String.raw`y\notin O`), " なら全単射 ", math(String.raw`F`),
        " により ", math(String.raw`F^{-1}(y)\notin O`),
        " なので両辺は零である。従って関数の等号を得る。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_claim_all_eigenvalues_roots",
    kind: "claim",
    title: { text: "複素固有値は有限位数の一の冪根である" },
    labels: ["claim_binary_ca_permutation_complex_eigenvalue_root_of_unity"],
    habitat: "C",
    realEscape:
      "整数置換行列の複素固有値を述べるため複素係数作用を用いる。極限、内積、完備性、複素対数は使わない。",
    statement: [
      paragraph([
        math(String.raw`z:X\to\mathbb C`), " が零関数でなく、ある ",
        math(String.raw`\lambda\in\mathbb C`), " について ",
        math(String.raw`P_F^{\mathbb C}z=\lambda z`), " ならば",
      ]),
      displayMath(String.raw`\lambda^{L_F}=1`),
      paragraph(["である。従って複素固有値を導入しても、その値は有限位数から制約された代数的な一の冪根である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_binary_ca_reversible_global_finite_order_identity"), " を複素係数へ送ると ",
        math(String.raw`(P_F^{\mathbb C})^{L_F}=I`), " である。固有値等式を ",
        math(String.raw`L_F`), " 回反復して",
      ]),
      displayMath(String.raw`z=(P_F^{\mathbb C})^{L_F}z=\lambda^{L_F}z`),
      paragraph([
        "を得る。", math(String.raw`z(y)\neq0`), " となる ", math(String.raw`y\in X`),
        " を選び、その成分で非零複素数 ", math(String.raw`z(y)`),
        " を消去すると ", math(String.raw`\lambda^{L_F}=1`), " である。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_definition_real_phase_generator",
    kind: "definition",
    title: { text: "時間尺度を選んだ実数値位相生成子" },
    labels: ["def_binary_ca_real_phase_generator"],
    habitat: "mixed",
    realEscape:
      "複素位相を実数値の変化率で表示する比較対象として、正の実数時間尺度、実円周定数、実数除算および複素指数関数を用いる。複素対数は定義しない。",
    statement: [
      paragraph([
        ref("def_binary_ca_reversible_phase_complex_realization"), " と正の時間尺度 ",
        math(String.raw`\tau\in\mathbb R_{>0}`), " に対し、写像 ",
        math(String.raw`G:\operatorname{Ph}(F)\to\mathbb R`), " が",
      ]),
      displayMath(String.raw`\exp_{\mathbb C}\!\left(
  \mathrm i\tau G(O,k)
\right)=\rho_F(O,k)
\qquad((O,k)\in\operatorname{Ph}(F))`),
      paragraph([
        "を満たすとき、時間尺度 ", math(String.raw`\tau`),
        " に対する実数値位相生成子と呼ぶ。これは有限位相符号上の実数値写像の定義であり、",
        "内積、完備性、線形作用素を仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_permutation_complex_phase_boundary_claim_generator_nonunique",
    kind: "claim",
    title: { text: "有限時間発展は実数値位相生成子を一意に定めない" },
    labels: ["claim_binary_ca_real_phase_generator_not_unique"],
    habitat: "mixed",
    realEscape:
      "有限位相符号の複素指数実現を実数値生成子へ持ち上げる際、正の実数時間尺度と実円周定数を用いる。複素対数を選ばず、全ての整数持ち上げを明示する。",
    statement: [
      paragraph([
        "任意の ", math(String.raw`n\in\mathbb Z`), " に対し",
      ]),
      displayMath(String.raw`G_n(O,k):=
\frac{2\pi_{\mathbb R}}{\tau}
\left(
  \frac{k}{|O|}+n
\right)`),
      paragraph([
        "と定めると、全ての ", math(String.raw`G_n`), " は ",
        ref("def_binary_ca_real_phase_generator"), " の条件を満たす。一方、",
        math(String.raw`n\neq m`), " なら ", math(String.raw`G_n\neq G_m`),
        " である。従って、同じ有限可逆時間発展、同じ複素位相実現、同じ正の時間尺度からも、",
        "実数値位相生成子は一意に決まらない。",
      ]),
    ],
    proof: [
      paragraph(["複素指数関数の加法則と整数周期性により"]),
      displayMath(String.raw`\begin{aligned}
\exp_{\mathbb C}\!\left(\mathrm i\tau G_n(O,k)\right)
&=\exp_{\mathbb C}\!\left(
  2\pi_{\mathbb R}\mathrm i
  \left(\frac{k}{|O|}+n\right)
\right)
  \quad(\because\ G_n\ \text{の定義})\\
&=\exp_{\mathbb C}\!\left(
  2\pi_{\mathbb R}\mathrm i\frac{k}{|O|}
\right)
  \quad(\because\ n\in\mathbb Z\ \text{と複素指数関数の整数周期性})\\
&=\rho_F(O,k)
  \quad(\because\ \blkref{def_binary_ca_reversible_phase_complex_realization}).
\end{aligned}`),
      paragraph([
        math(String.raw`\operatorname{Ph}(F)`), " は空でない。任意の位相符号で",
      ]),
      displayMath(String.raw`G_n(O,k)-G_m(O,k)
=\frac{2\pi_{\mathbb R}}{\tau}(n-m)\neq0
\qquad(\because\ \tau>0,\ \pi_{\mathbb R}>0,\ n\neq m)`),
      paragraph([
        "なので写像も異なる。非一意性は有限データの不足ではなく、複素指数写像が整数周期を持つために生じる。",
        "時間尺度と整数持ち上げを追加で選ばない限り、実数値生成子を有限時間発展と同一視できない。",
      ]),
    ],
  },
]);
