import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_qbar_polynomial_square_root_archive_def_qbar_formal_power_series",
    targets: ["claim_qbar_polynomial_square_root_unique"],
    title: { text: "旧定義：代数的数係数の形式的冪級数" },
    body: [
paragraph(["このノートは不採用経路の原文を保存したものであり、本文の多項式平方根の定義・証明ではない。"]),
paragraph([math(String.raw`\overline{\mathbb Q}^{\mathbb N}`), " は非可算である。各係数の Cauchy 積が有限和であることと、無限列全体が可算であることは別である。本文は有限多項式だけで平方根を扱えるため、この経路を採用しない。"]),
paragraph(["以下の原文中の『可算集合』という記述は誤りである。誤記を含めて保存しており、正しい記述として再利用しない。"]),
paragraph(["旧定義の原文。"]),
                      paragraph([
                        "代数的数の列 ", math(String.raw`C=(c_n)_{n\in\mathbb N}`),
                        " を代数的数係数の形式的冪級数と呼び、",
                      ]),
                      displayMath(String.raw`C(x)=\sum_{n\in\mathbb N}c_nx^n\in\overline{\mathbb Q}[[x]]`),
                      paragraph([
                        "と書く。二つの形式的冪級数 ", math(String.raw`C(x)=\sum_n c_nx^n`),
                        " と ", math(String.raw`E(x)=\sum_n e_nx^n`), " の積は Cauchy 積",
                      ]),
                      displayMath(String.raw`C(x)E(x):=\sum_{n\in\mathbb N}\left(\sum_{j=0}^{n}c_je_{n-j}\right)x^n`),
                      paragraph(["で、和と加法逆元は係数ごとに"]),
                      displayMath(String.raw`C(x)+E(x):=\sum_{n\in\mathbb N}(c_n+e_n)x^n,\qquad -C(x):=\sum_{n\in\mathbb N}(-c_n)x^n`),
                      paragraph([
                        "で定める。差は ", math(String.raw`C(x)-E(x):=C(x)+\bigl(-E(x)\bigr)`),
                        " と書く。各係数に現れる和は有限である。定数項を ",
                        math(String.raw`\mathrm{ac}_0(C):=c_0`), " と書く。これは可算集合 ",
                        math(String.raw`\overline{\mathbb Q}^{\mathbb N}`),
                        " と代数的数の有限和・有限積だけで定まり、実数体も複素数体も現れない。",
                      ]),
    ],
  },
  {
    id: "note_qbar_polynomial_square_root_archive_claim_formal_square_root_unique",
    targets: ["claim_qbar_polynomial_square_root_unique"],
    title: { text: "旧主張：定数項一の形式的平方根の一意性" },
    body: [
paragraph(["このノートは不採用経路の原文を保存したものであり、本文の多項式平方根の定義・証明ではない。"]),
paragraph([math(String.raw`\overline{\mathbb Q}^{\mathbb N}`), " は非可算である。各係数の Cauchy 積が有限和であることと、無限列全体が可算であることは別である。本文は有限多項式だけで平方根を扱えるため、この経路を採用しない。"]),
paragraph(["旧主張の原文。"]),
                  paragraph([
                    math(String.raw`D,S,T\in\overline{\mathbb Q}[[x]]`), " とする。",
                    math(String.raw`\mathrm{ac}_0(S)=\mathrm{ac}_0(T)=1`), " かつ",
                  ]),
                  displayMath(String.raw`S(x)S(x)=D(x)=T(x)T(x)`),
                  paragraph(["ならば ", math(String.raw`S(x)=T(x)`), " である。"]),
paragraph(["旧証明の原文。"]),
                  paragraph(["二つの平方の等式から、求めたい差を因数に持つ積を作る。"]),
                  displayMath(String.raw`\begin{aligned}
\bigl(S(x)-T(x)\bigr)\bigl(S(x)+T(x)\bigr)
&=S(x)S(x)-T(x)T(x)
&&\bigl(\because\ \overline{\mathbb Q}[[x]]\text{ の分配則}\bigr)\\
&=D(x)-D(x)
&&\bigl(\because\ S(x)S(x)=D(x)=T(x)T(x)\text{（仮定）}\bigr)\\
&=0
&&\bigl(\because\ \overline{\mathbb Q}[[x]]\text{ の加法逆元}\bigr)
\end{aligned}`),
                  paragraph([
                    math(String.raw`\overline{\mathbb Q}`),
                    " は体なので零因子を持たず、形式的冪級数の積も、最初の非零係数どうしの積を見ることで零因子を持たない。したがって ",
                    math(String.raw`S(x)-T(x)=0`), " または ", math(String.raw`S(x)+T(x)=0`),
                    " である。後者なら定数項を取って",
                  ]),
                  displayMath(String.raw`\begin{aligned}
0&=\mathrm{ac}_0\bigl(S(x)+T(x)\bigr)
&&\bigl(\because\ S(x)+T(x)=0\text{ と }\mathrm{ac}_0(0)=0.\ \text{ノート「旧定義：代数的数係数の形式的冪級数」}\bigr)\\
&=\mathrm{ac}_0(S)+\mathrm{ac}_0(T)
&&\bigl(\because\ \text{和は係数ごとの和である。}\text{ノート「旧定義：代数的数係数の形式的冪級数」}\bigr)\\
&=1+1
&&\bigl(\because\ \mathrm{ac}_0(S)=\mathrm{ac}_0(T)=1\text{（仮定）}\bigr)\\
&=2
&&\bigl(\because\ \overline{\mathbb Q}\text{ の加法}\bigr)
\end{aligned}`),
                  paragraph([
                    "となるが、", math(String.raw`2\ne0`), " は ", math(String.raw`\overline{\mathbb Q}`),
                    " の標数が零であることに反する。ゆえに ", math(String.raw`S(x)-T(x)=0`),
                    " であり、", math(String.raw`S(x)=T(x)`), " である。",
                  ]),
paragraph(["旧Lean対応：Ising2DLambda.KacWard.formalSquareRoot_unique、Ising2DLambda.NecSuf.KacWard.formalSquareRoot_unique_necSuf、Ising2DLambda.KacWard.formalSquareRoot_unique_from_necSuf。形式級数についての宣言を参照用に保存する。"]),
paragraph(["旧SageMath対応：sagemath/check/formal-square-root-uniqueness。有限標本・有限打切りだけを検算しており、無限列全体の可算性も本文の多項式命題も検証していない。"]),
    ],
  },
  {
    id: "note_qbar_polynomial_square_root_archive_def_sqrt_coefficient_recursion",
    targets: ["claim_qbar_polynomial_square_root_unique"],
    title: { text: "旧定義：平方根係数列の再帰" },
    body: [
paragraph(["このノートは不採用経路の原文を保存したものであり、本文の多項式平方根の定義・証明ではない。"]),
paragraph([math(String.raw`\overline{\mathbb Q}^{\mathbb N}`), " は非可算である。各係数の Cauchy 積が有限和であることと、無限列全体が可算であることは別である。本文は有限多項式だけで平方根を扱えるため、この経路を採用しない。"]),
paragraph(["旧定義の原文。"]),
                      paragraph([
                        "代数的数の列 ", math(String.raw`D=(d_n)_{n\in\mathbb N}`),
                        " が ", math(String.raw`d_0=1`),
                        " を満たすとする。代数的数の列 ", math(String.raw`s=(s_n)_{n\in\mathbb N}`),
                        " を、添字 ", math(String.raw`n\in\mathbb N`), " についての再帰",
                      ]),
                      displayMath(String.raw`s_0:=1,\qquad
s_n:=\frac{1}{2}\left(d_n-\sum_{j=1}^{n-1}s_js_{n-j}\right)\quad(n\ge1)`),
                      paragraph([
                        "で定め、", math(String.raw`D`), " の平方根係数列と呼ぶ。右辺の和は ",
                        math(String.raw`j`), " が ", math(String.raw`1`), " から ",
                        math(String.raw`n-1`), " までを走る有限和であり（",
                        math(String.raw`n=1`), " では空和で、その値は ",
                        math(String.raw`0\in\overline{\mathbb Q}`),
                        " とする）、現れる ", math(String.raw`s_j`),
                        " の添字はいずれも ", math(String.raw`n`),
                        " より小さいので、この再帰は各 ", math(String.raw`s_n\in\overline{\mathbb Q}`),
                        " を一意に定める。", math(String.raw`2`), " による除法は、",
                        math(String.raw`\overline{\mathbb Q}`), " が体であり ",
                        math(String.raw`2\ne0`), "（標数零）だから定義される。",
                      ]),
    ],
  },
  {
    id: "note_qbar_polynomial_square_root_archive_claim_formal_square_root_exists",
    targets: ["claim_qbar_polynomial_square_root_unique"],
    title: { text: "旧主張：定数項一の形式的平方根の存在" },
    body: [
paragraph(["このノートは不採用経路の原文を保存したものであり、本文の多項式平方根の定義・証明ではない。"]),
paragraph([math(String.raw`\overline{\mathbb Q}^{\mathbb N}`), " は非可算である。各係数の Cauchy 積が有限和であることと、無限列全体が可算であることは別である。本文は有限多項式だけで平方根を扱えるため、この経路を採用しない。"]),
paragraph(["旧主張の原文。"]),
                  paragraph([
                    math(String.raw`D(x)=\sum_{n\in\mathbb N}d_nx^n\in\overline{\mathbb Q}[[x]]`),
                    " が ", math(String.raw`\mathrm{ac}_0(D)=1`),
                    " を満たすとする。", math(String.raw`D`),
                    " の平方根係数列 ", math(String.raw`s`), "（",
                    "ノート「旧定義：平方根係数列の再帰」", "）から作る形式的冪級数を ",
                    math(String.raw`S(x):=\sum_{n\in\mathbb N}s_nx^n\in\overline{\mathbb Q}[[x]]`),
                    " と置くと、",
                    math(String.raw`\mathrm{ac}_0(S)=1`), " かつ ",
                    math(String.raw`S(x)S(x)=D(x)`), " である。",
                  ]),
paragraph(["旧証明の原文。"]),
                  paragraph(["定数項について、"]),
                  displayMath(String.raw`\begin{aligned}
\mathrm{ac}_0(S)
&=s_0
&&\bigl(\because\ \text{ノート「旧定義：代数的数係数の形式的冪級数」}\bigr)\\
&=1
&&\bigl(\because\ \text{ノート「旧定義：平方根係数列の再帰」}\bigr)
\end{aligned}`),
                  paragraph([
                    "である。形式的冪級数は係数列そのものだから、",
                    math(String.raw`S(x)S(x)=D(x)`),
                    " を示すには、すべての ", math(String.raw`n\in\mathbb N`),
                    " について Cauchy 積の ", math(String.raw`n`),
                    " 次係数が ", math(String.raw`d_n`),
                    " に一致することを示せばよい（",
                    math(String.raw`\because`), " ", "ノート「旧定義：代数的数係数の形式的冪級数」",
                    "）。", math(String.raw`n=0`), " のとき:",
                  ]),
                  displayMath(String.raw`\begin{aligned}
\sum_{j=0}^{0}s_js_{0-j}
&=s_0s_0
&&\bigl(\because\ \text{一項の和}\bigr)\\
&=1\cdot1
&&\bigl(\because\ s_0=1.\ \text{ノート「旧定義：平方根係数列の再帰」}\bigr)\\
&=1
&&\bigl(\because\ \overline{\mathbb Q}\text{ の乗法単位元}\bigr)\\
&=d_0
&&\bigl(\because\ \mathrm{ac}_0(D)=1\text{（仮定）と }\mathrm{ac}_0(D)=d_0.\ \text{ノート「旧定義：代数的数係数の形式的冪級数」}\bigr)
\end{aligned}`),
                  paragraph([
                    math(String.raw`n\ge1`), " のとき（",
                    math(String.raw`n=1`), " では ",
                    math(String.raw`\sum_{j=1}^{n-1}`),
                    " は空和で値は ", math(String.raw`0`), " である）:",
                  ]),
                  displayMath(String.raw`\begin{aligned}
\sum_{j=0}^{n}s_js_{n-j}
&=s_0s_n+\left(\sum_{j=1}^{n-1}s_js_{n-j}\right)+s_ns_0
&&\bigl(\because\ \text{有限和から }j=0\text{ と }j=n\text{ の項を分ける}\bigr)\\
&=s_n+\left(\sum_{j=1}^{n-1}s_js_{n-j}\right)+s_n
&&\bigl(\because\ s_0=1\text{ と }\overline{\mathbb Q}\text{ の乗法単位元}.\ \text{ノート「旧定義：平方根係数列の再帰」}\bigr)\\
&=2s_n+\sum_{j=1}^{n-1}s_js_{n-j}
&&\bigl(\because\ \overline{\mathbb Q}\text{ の加法と分配則}\bigr)\\
&=\left(d_n-\sum_{j=1}^{n-1}s_js_{n-j}\right)+\sum_{j=1}^{n-1}s_js_{n-j}
&&\bigl(\because\ 2s_n=d_n-\textstyle\sum_{j=1}^{n-1}s_js_{n-j}.\ \text{ノート「旧定義：平方根係数列の再帰」}\bigr)\\
&=d_n
&&\bigl(\because\ \overline{\mathbb Q}\text{ の加法逆元}\bigr)
\end{aligned}`),
                  paragraph([
                    "ゆえにすべての ", math(String.raw`n\in\mathbb N`),
                    " で Cauchy 積の ", math(String.raw`n`), " 次係数は ",
                    math(String.raw`d_n`), " に一致し、",
                    math(String.raw`S(x)S(x)=D(x)`), " である。",
                  ]),
paragraph(["旧Lean対応：Ising2DLambda.KacWard.formalSquareRoot_exists、Ising2DLambda.NecSuf.KacWard.mk_sqrtCoeff_mul_self、Ising2DLambda.KacWard.formalSquareRoot_exists_from_necSuf。形式級数についての宣言を参照用に保存する。"]),
paragraph(["旧SageMath対応：sagemath/check/formal-square-root-existence。有限標本・有限打切りだけを検算しており、無限列全体の可算性も本文の多項式命題も検証していない。"]),
    ],
  },
]);
