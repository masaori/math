import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「固有値問題」の章「A(θ̃_μ) の対角化と V^{(+)} の指数表示」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_diagonalization_and_exponential_form",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化と }V^{(+)}\text{ の指数表示}` },
    labels: [],
  },
  {
    id: "transfer_matrix_000h2_definition_arccosh",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦" },
    labels: ["def_arccosh"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " が ",
        math(String.raw`y \ge 1`),
        " を満たすとき、",
      ]),
      displayMath(
        String.raw`\mathrm{arccosh}(y) := \log\!\left(y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}\right) \in \mathbb{R}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        "、",
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        " である。右辺が定まることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y \ge 1
&\Longrightarrow y^2 - 1 \ge 0
   &&(\because\ y \ge 1 > 0 \text{ より } y^2 \ge 1) \\
y \ge 1 \ \land\ \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 0
&\Longrightarrow y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 1 > 0
   &&(\because\ \text{実数の順序と加法})
\end{aligned}`,
      ),
      paragraph([
        "すなわち平方根の中身は非負であり、",
        math(String.raw`\log`),
        " の引数は正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "それまで本文は arccosh を「cosh|_[0,∞) の逆写像」と呼ぶだけで定義を置いていなかった。逆写像として定義すると cosh|_[0,∞) が [1,∞) への全単射であることを先に示す必要があるので、log と非負平方根による式で定義し、逆写像であることを arccosh_properties で示す形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000h3_claim_arccosh_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦は非負側の双曲線余弦の逆" },
    labels: ["arccosh_properties"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        "、",
        math(String.raw`y \ge 1`),
        " とする。",
        ref("def_arccosh"),
        " の ",
        math(String.raw`\mathrm{arccosh}`),
        " と ",
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\cosh`),
        " について次が成り立つ。",
      ]),
      list([
        ["(1) ", math(String.raw`\mathrm{arccosh}(y) \ge 0`), "。"],
        ["(2) ", math(String.raw`\cosh\!\left(\mathrm{arccosh}(y)\right) = y`), "。"],
        [
          "(3) ",
          math(String.raw`t \in \mathbb{R}`),
          " が ",
          math(String.raw`t \ge 0`),
          " かつ ",
          math(String.raw`\cosh t = y`),
          " を満たすなら ",
          math(String.raw`t = \mathrm{arccosh}(y)`),
          "。",
        ],
        ["(4) ", math(String.raw`\mathrm{arccosh}(1) = 0`), "。"],
      ]),
    ],
    proof: [
      paragraph([
        "準備。証明の中だけの記号として ",
        math(String.raw`r := \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \in \mathbb{R}`),
        "、",
        math(String.raw`u := \mathrm{arccosh}(y) \in \mathbb{R}`),
        " とおく（",
        math(String.raw`y^2 - 1 \ge 0`),
        " は ",
        ref("def_arccosh"),
        " で示した）。（実対数と平方根による ",
        math(String.raw`\mathbb R`),
        " 脱出）",
        math(String.raw`r`),
        " は ",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " の存在（",
        math(String.raw`\mathbb{R}`),
        " の完備性）で定まる実数、",
        math(String.raw`u`),
        " と以下の ",
        math(String.raw`\exp`),
        "・",
        math(String.raw`\log`),
        "・",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値は実数の指数関数と実対数（",
        ref("def_real_logarithm_positive"),
        "）の値であり、",
        math(String.raw`\mathbb{Q}`),
        " には一般に収まらない（",
        math(String.raw`y`),
        " によっては収まる）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&r \ge 0 \ \land\ r^2 = y^2 - 1
   &&(\because\ \blkref{definition_of_sqrt_r_positive}) \\
&u = \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&y + r \ge 1
   &&(\because\ \blkref{def_arccosh})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\log 1
&= \log(\exp(0))
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= 0
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x) = x)
\end{aligned}`,
      ),
      paragraph([
        "(1) の証明。",
        math(String.raw`y + r \ge 1`),
        " なので ",
        math(String.raw`y + r > 1`),
        " か ",
        math(String.raw`y + r = 1`),
        " である。",
        math(String.raw`y + r > 1`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&= \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&> \log 1
   &&(\because\ y + r > 1 \text{ と } \blkref{real_log_strictly_increasing}) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
      paragraph([math(String.raw`y + r = 1`), " の場合。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&= \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&= \log 1
   &&(\because\ y + r = 1) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\mathrm{arccosh}(y) \ge 0`),
        " である。",
      ]),
      paragraph(["(2) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(u)
&= \exp(\log(y + r))
   &&(\because\ u = \log(y + r)) \\
&= y + r
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log z) = z)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
y^2 - r^2
&= y^2 - (y^2 - 1)
   &&(\because\ r^2 = y^2 - 1) \\
&= 1
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-u)
&= \exp(-u)\,(y^2 - r^2)
   &&(\because\ y^2 - r^2 = 1) \\
&= \exp(-u)\,\bigl((y + r)(y - r)\bigr)
   &&(\because\ \text{和と差の積}) \\
&= \exp(-u)\,\bigl(\exp(u)\,(y - r)\bigr)
   &&(\because\ \exp(u) = y + r) \\
&= \bigl(\exp(-u)\exp(u)\bigr)\,(y - r)
   &&(\because\ \mathbb{R} \text{ の積の結合律}) \\
&= \exp(-u + u)\,(y - r)
   &&(\because\ \blkref{scalar_exp_product}) \\
&= \exp(0)\,(y - r)
   &&(\because\ -u + u = 0) \\
&= 1 \cdot (y - r)
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= y - r
   &&(\because\ 1 \text{ は } \mathbb{R} \text{ の積の単位元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh\!\left(\mathrm{arccosh}(y)\right)
&= \cosh(u)
   &&(\because\ u \text{ の定め方}) \\
&= \frac{\exp(u) + \exp(-u)}{2}
   &&(\because\ \blkref{def_cosh_sinh}) \\
&= \frac{(y + r) + \exp(-u)}{2}
   &&(\because\ \exp(u) = y + r) \\
&= \frac{(y + r) + (y - r)}{2}
   &&(\because\ \exp(-u) = y - r) \\
&= \frac{2y}{2}
   &&(\because\ \mathbb{R} \text{ の加法}) \\
&= y
   &&(\because\ \text{約分})
\end{aligned}`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`t \in \mathbb{R}`),
        "、",
        math(String.raw`t \ge 0`),
        "、",
        math(String.raw`\cosh t = y`),
        " とする。まず ",
        math(String.raw`\sinh t \ge 0`),
        " を示す。",
        math(String.raw`t > 0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\sinh t > 0
   &&(\because\ t > 0 \text{ と } \blkref{cosh_sinh_basic_properties}\text{ (3)})
\end{aligned}`,
      ),
      paragraph([math(String.raw`t = 0`), " の場合。"]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 0
&= \frac{\exp(0) - \exp(-0)}{2}
   &&(\because\ \blkref{def_cosh_sinh}) \\
&= \frac{\exp(0) - \exp(0)}{2}
   &&(\because\ -0 = 0) \\
&= \frac{1 - 1}{2}
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= 0
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\sinh t \ge 0`),
        " である。次に",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sinh t)^2
&= (\cosh t)^2 - 1
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2) と移項}) \\
&= y^2 - 1
   &&(\because\ \cosh t = y)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh t
&= \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \sinh t \ge 0\text{、}(\sinh t)^2 = y^2 - 1 \text{ と } \blkref{definition_of_sqrt_r_positive}\text{（}\blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性）}) \\
&= r
   &&(\because\ r \text{ の定め方})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
t
&= \log(\exp(t))
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x) = x) \\
&= \log(\cosh t + \sinh t)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (1)}) \\
&= \log(y + \sinh t)
   &&(\because\ \cosh t = y) \\
&= \log(y + r)
   &&(\because\ \sinh t = r) \\
&= \mathrm{arccosh}(y)
   &&(\because\ \blkref{def_arccosh})
\end{aligned}`,
      ),
      paragraph(["(4) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(1)
&= \log\!\left(1 + \sqrt{1^2-1}^{(\mathbb{R}_{\ge 0})}\right)
   &&(\because\ \blkref{def_arccosh}) \\
&= \log\!\left(1 + \sqrt{0}^{(\mathbb{R}_{\ge 0})}\right)
   &&(\because\ 1^2 - 1 = 0) \\
&= \log(1 + 0)
   &&(\because\ 0 \ge 0\text{、}0^2 = 0 \text{ と } \blkref{definition_of_sqrt_r_positive}\text{（}\blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性）}) \\
&= \log 1
   &&(\because\ 1 + 0 = 1) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "arccosh を式で定義したことに伴い、本文が使っている性質（非負・cosh との合成・非負側での一意性・arccosh(1)=0）を主張として置いた。",
        "2026-11-02: SageMath の検算（sagemath/check/arccosh_properties/）を付けるにあたり、証明を直した。log 1 = 0 を「def_real_logarithm_positive の証明で示した」と引いていたが、その定義に証明は無いので、scalar_exp_zero と log(exp x) = x からの鎖を準備に置いた。exp(-u)exp(u) = exp(0) の行を積の結合律・指数法則・-u+u=0 の三行に、cosh の鎖の「上の 2 式」を二行に、(3) の二つの代入と (4) の 1^2-1=0・√0=0 を一行ずつに分けた。(1) と (3) の sinh t ≥ 0 を場合分けの鎖に、√ の一意性を散文から (∵) 付きの式に移し、実対数と平方根による ℝ 脱出を準備に書いた。主張は変えていない。",
      ],
    },
  },
  {
    id: "transfer_matrix_015_claim_Z_Y_generate_algebra",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ", ordinal: 15 },
    title: {
      text: "Z, Y から和・スカラー倍・積だけで 2^M 次の複素行列がすべて得られる",
    },
    labels: ["Z_Y_generate_algebra"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        "（004 章冒頭の記号の定義）で定義された ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、集合 ",
        math(String.raw`S := \{Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}}\}`),
        " を考える（",
        ref("def_kronecker"),
        " の同一視により ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " であり、",
        math(String.raw`S`),
        " の元はいずれも ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列である）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が「閉じている」とは、次の 4 条件を満たすことをいう。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`S \subseteq T`),
          "、すなわち ",
          math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}} \in T`),
          "。",
        ],
        [
          "(ii) ",
          math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \in T`),
          "（単位行列を含む）。",
        ],
        [
          "(iii) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`A + B \in T`),
          "、および ",
          math(String.raw`c \in \mathbb{C}`),
          " について ",
          math(String.raw`cA \in T`),
          "（和とスカラー倍で閉じる）。",
        ],
        [
          "(iv) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`AB \in T`),
          "（行列の積で閉じる）。",
        ],
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " 自身は閉じているからそのような ",
        math(String.raw`T`),
        " は少なくとも 1 つ存在し、閉じている部分集合すべての共通部分もまた (i)〜(iv) を満たす",
        "（共通部分の元は各 ",
        math(String.raw`T`),
        " に属するので、和・スカラー倍・積も各 ",
        math(String.raw`T`),
        " に属し、したがって共通部分に属する）。よって、閉じている部分集合のうち最小のものが存在する。それを ",
        math(String.raw`\mathcal{A}`),
        " とおく。",
      ]),
      paragraph([
        "このとき ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " である。すなわち、",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        " と単位行列から出発して、和・スカラー倍・行列の積を有限回繰り返すだけで ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列がすべて得られる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列 ",
        math(String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " とする。",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のとおり、第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが対応する Pauli 行列で、他の因子はすべて ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " であるものとする。",
      ]),
      paragraph(["Step 1: 単一サイトの Pauli 行列の積公式。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= I_{\mathrm{Mat}(2,\mathbb{C})} \quad (\because \text{単位行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix} \quad (\because \sigma^y,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&i\\i&0\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= i\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \text{スカラー倍の成分計算}) \\
&= i\,\sigma^x \quad (\because \sigma^x \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["第 2 式から ", math(String.raw`\sigma^x`), " を書き直す。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x
&= 1\cdot\sigma^x \quad (\because 1 \text{ は積の単位元}) \\
&= ((-i)\,i)\,\sigma^x \quad (\because (-i)\,i = 1) \\
&= -i\,(i\,\sigma^x) \quad (\because \text{スカラー倍の結合則}) \\
&= -i\,\sigma^y\sigma^z \quad (\because \text{第 2 式 } \sigma^y\sigma^z = i\,\sigma^x)
\end{aligned}`,
      ),
      paragraph([
        "これらをクロネッカー積へ持ち上げる。",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の積は各因子ごとの積であり ",
        math(String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}}) = (A_1 B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}} B_{M_{\mathrm{col}}})`),
        "（",
        ref("kronecker_product_rule"),
        " (1)）。第 ",
        math(String.raw`k`),
        " 因子のみが非自明な ",
        math(String.raw`\sigma_k^a`),
        " どうしの積は（",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_k^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_k^b \text{ の定義の代入}) \\
&= (II)\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes(II) \quad (\because \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes I \quad (\because II=I)
\end{aligned}`,
      ),
      paragraph([
        "これより ",
        math(String.raw`\sigma_k^x\sigma_k^x = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\sigma_k^x = -i\,\sigma_k^y\sigma_k^z`),
        " を得る。また異なるサイト ",
        math(String.raw`k\neq l`),
        " の ",
        math(String.raw`\sigma_k^a, \sigma_l^b`),
        " は可換である（",
        math(String.raw`k<l`),
        " として）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_l^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_l^b \text{ の定義の代入}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I \quad (\because \text{クロネッカー積の積の規則}) \\
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma_l^b \sigma_k^a \quad (\because \sigma_l^b, \sigma_k^a \text{ の定義（第 } l \text{ 因子・第 } k \text{ 因子のみが非自明）})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathcal{A}`),
        " が各 ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " を含むこと。各 ",
        math(String.raw`m`),
        " について「",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x \in \mathcal{A}`),
        "」を仮定とする ",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のとき ",
        math(String.raw`\sigma_1^z=Z_1\in\mathcal{A}`),
        "、",
        math(String.raw`\sigma_1^y=Y_1\in\mathcal{A}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^x
&= -i\,\sigma_1^y\sigma_1^z \quad (\because \text{Step 1 の } \sigma_k^x = -i\,\sigma_k^y\sigma_k^z \text{ を } k=1 \text{ に取る}) \\
&= -i\,Y_1 Z_1 \quad (\because \sigma_1^y = Y_1, \ \sigma_1^z = Z_1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_1, Z_1\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_1^x\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        math(String.raw`m\geq 2`),
        " とし ",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x\in\mathcal{A}`),
        " を仮定する。",
        math(String.raw`P_{m-1}:=\sigma_1^x\sigma_2^x\cdots\sigma_{m-1}^x`),
        " とおくと ",
        math(String.raw`P_{m-1}\in\mathcal{A}`),
        "（",
        math(String.raw`m=1`),
        " では空積 ",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "）。異サイトの可換性と ",
        math(String.raw`\sigma_k^x\sigma_k^x=I`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}P_{m-1}
&= (\sigma_1^x\cdots\sigma_{m-1}^x)(\sigma_1^x\cdots\sigma_{m-1}^x) \quad (\because P_{m-1} \text{ の定義}) \\
&= (\sigma_1^x\sigma_1^x)(\sigma_2^x\sigma_2^x)\cdots(\sigma_{m-1}^x\sigma_{m-1}^x) \quad (\because \text{異サイトの可換性}) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \quad (\because \sigma_k^x\sigma_k^x=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに ",
        math(String.raw`P_{m-1}`),
        " は可逆で ",
        math(String.raw`P_{m-1}^{-1}=P_{m-1}\in\mathcal{A}`),
        "。定義より ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z = P_{m-1}\sigma_m^z`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Z_m
&= P_{m-1}P_{m-1}\sigma_m^z \quad (\because Z_m = P_{m-1}\sigma_m^z) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^z \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^z \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Z_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^z = P_{m-1}Z_m\in\mathcal{A}`),
        "。",
        math(String.raw`\sigma_m^y`),
        " についても同じ形の鎖が書ける。定義より ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y = P_{m-1}\sigma_m^y`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Y_m
&= P_{m-1}P_{m-1}\sigma_m^y \quad (\because Y_m = P_{m-1}\sigma_m^y) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^y \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^y \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Y_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^y = P_{m-1}Y_m\in\mathcal{A}`),
        "。さらに Step 1 より ",
        math(String.raw`\sigma_m^x = -i\,\sigma_m^y\sigma_m^z`),
        " であり、",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_m^x\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\sigma_m^x,\sigma_m^y,\sigma_m^z\in\mathcal{A}`),
        " が示され、帰納法により すべての ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。まず ",
        math(String.raw`\mathcal{B}:=\{I_{\mathrm{Mat}(2,\mathbb{C})}, \sigma^x, \sigma^y, \sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 上の基底である。実際、任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = \frac{a_{11}+a_{22}}{2}I_{\mathrm{Mat}(2,\mathbb{C})} + \frac{a_{12}+a_{21}}{2}\sigma^x + \frac{i(a_{12}-a_{21})}{2}\sigma^y + \frac{a_{11}-a_{22}}{2}\sigma^z \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{B}`),
        " は張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " より基底である。次に ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}:=\{e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}: e_1,\dots,e_{M_{\mathrm{col}}}\in\mathcal{B}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}`),
        " に適用した）。一方、各 ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}`),
        " について、各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\sigma_k^{a_k}:=I\boxtimes\cdots\boxtimes\overbrace{e_k}^{k\text{th}}\boxtimes\cdots\boxtimes I`),
        " とおくと、Step 1 の異サイト積公式を繰り返して",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}} = e_1\boxtimes e_2\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} \quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "Step 2 より各 ",
        math(String.raw`\sigma_k^{a_k}\in\mathcal{A}`),
        "（",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\in\mathcal{A}`),
        " も含む）であり、",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} = \sigma_1^{a_1}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}}\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}\subseteq\mathcal{A}`),
        "。",
        math(String.raw`\mathcal{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}`),
        " は基底であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{span}_{\mathbb{C}}(\mathcal{B}^{\boxtimes M_{\mathrm{col}}}) \subseteq \mathcal{A} \quad (\because \mathcal{A} \text{ は } \mathbb{C}\text{-線型結合について閉じる})`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathcal{A}\subseteq\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は定義より明らかであるから ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "タイトルと statement にあった多元環の一般論の語彙（「環として生成する」「C 上の単位的結合多元環」" +
          "「S を含む最小の C-部分多元環」）を、「和・スカラー倍・積で閉じた最小の集合」という具体的な" +
          "言い換えへ直した（goal-alignment-audit の A-6。README 2 節「環・体などの一般論に持ち上げた証明」" +
          "を避けるため）。主張の内容と証明は変えていない。あわせて、最小の集合が存在すること" +
          "（閉じている部分集合の共通部分もまた閉じている）を明示した。",
      ],
    },
  },
  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ の共役添字恒等式 } \tilde\theta_{1-\mu} = -\tilde\theta_\mu` },
    labels: ["def_half_integer_modes"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について、旧複合主張の番号を保った次の恒等式が成り立つ。",
      ]),
      displayMath(String.raw`\text{(3) 共役添字：}\quad \tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
    ],
    proof: [
      paragraph([
        "(3) 共役添字について示す。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{1-\mu}
&=\frac{2\pi\left((1-\mu)_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta\text{ の定義を }1-\mu\in\mathbb Z\text{ で。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((\iota_{\mathbb Z\to\mathbb R}(1)-\mu_{\mathbb R})-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので差を保つ。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((1_{\mathbb R}-\mu_{\mathbb R})-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は単位元を保つ。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((1_{\mathbb R}-\tfrac12)-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の結合律と交換律}\bigr)\\
&=\frac{2\pi\left(\tfrac12-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ 1_{\mathbb R}-\tfrac12=\tfrac12\bigr)\\
&=\frac{2\pi\left(-\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ で }\tfrac12-\mu_{\mathbb R}=-\left(\mu_{\mathbb R}-\tfrac12\right)\bigr)\\
&=-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の積と }(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数から }-1\text{ をくくり出す}\bigr)\\
&=-\tilde\theta_\mu
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベルは、後続参照の意味を保つため、共役添字恒等式だけを述べる残余主張に残した。",
        "2026-11-03（全証明の SageMath 検算）: 鎖を antiperiodic_exp_sum の像の記号 μ_R・(M_col)_R で書き直し、整数から実数への包含が差と単位元を保つ行を分けた（主張は不変）。",
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
      ],
    },
  },
  {
    id: "evensector_003b_claim_conjugate_index_of_check_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 7 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{ の内側で共役添字を取る}` },
    labels: ["conjugate_index_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu`)],
        [
          math(
            String.raw`\text{(2)}\quad \exp(-i(j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu})_{\mathbb C}) = \exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
\qquad (j \in \mathbb{Z})`,
          ),
        ],
        [
          math(
            String.raw`\text{(3)}\quad \check{Z}_{M_{\mathrm{col}}+1-\mu} = \check{Z}_{1-\mu},
\qquad \check{Y}_{M_{\mathrm{col}}+1-\mu} = \check{Y}_{1-\mu}`,
          ),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに (3) により、",
        ref("def_half_integer_modes"),
        " (3) の共役添字 ",
        math(String.raw`1-\mu`),
        "（これは ",
        math(String.raw`\mu \geq 2`),
        " では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に出る）を、つねに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の元である ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " で置き換えてよい。**以降つねにそうする。**",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`j_{\mathbb R}`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " の整数の実数への像、",
        math(String.raw`r_{\mathbb C}`),
        "（",
        math(String.raw`r\in\mathbb R`),
        "）は ",
        ref("inclusion_rr_to_cc"),
        " の像である。(2) の証明は全実数上の ",
        math(String.raw`\cos,\sin`),
        " の値 ",
        math(String.raw`\cos(2\pi n_{\mathbb R})=1_{\mathbb R}`),
        "、",
        math(String.raw`\sin(2\pi n_{\mathbb R})=0_{\mathbb R}`),
        "（",
        math(String.raw`n\in\mathbb Z`),
        "）を使う。全実数への拡張は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり未整備なので、(2) はその拡張を前提とする。",
      ]),
      paragraph([
        "(2) は ",
        ref("def_half_integer_modes"),
        " (3) の ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " が果たしていた役割を、",
        math(String.raw`\check{\mathcal{M}}`),
        " の内側で果たす（位相としては ",
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu}`),
        " は ",
        math(String.raw`-\tilde\theta_\mu`),
        " と ",
        math(String.raw`2\pi`),
        " しか違わない）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= \frac{2\pi\left((M_{\mathrm{col}}+1-\mu)_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \tilde\theta\text{ の定義を }M_{\mathrm{col}}+1-\mu\in\mathbb Z\text{ で。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\iota_{\mathbb Z\to\mathbb R}(1)-\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので和と差を保つ。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}-\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は単位元を保つ。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(1_{\mathbb R}-\tfrac12\right)-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律と交換律}\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\tfrac12-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ 1_{\mathbb R}-\tfrac12=\tfrac12\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(\tfrac12-\mu_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律（差は加法の逆元の和）}\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}-\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ で }\tfrac12-\mu_{\mathbb R}=-\left(\mu_{\mathbb R}-\tfrac12\right)\text{（}-(a-b)=-a+b\text{）と、差は加法の逆元の和}\bigr) \\
&= \frac{2\pi(M_{\mathrm{col}})_{\mathbb R}-2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr) \\
&= \frac{2\pi(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数の差}\bigr) \\
&= 2\pi-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ による約分}\bigr) \\
&= 2\pi - \tilde\theta_\mu
   &&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`j \in \mathbb{Z}`),
        " とする。準備として、指数の中の実数を (1) で書き直す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= j_{\mathbb R}\left(2\pi - \tilde\theta_\mu\right)
   &&(\because\ \text{直前の (1)}) \\
&= j_{\mathbb R}\cdot2\pi - j_{\mathbb R}\tilde\theta_\mu
   &&(\because\ \mathbb R\text{ の分配法則}) \\
&= 2\pi j_{\mathbb R} - j_{\mathbb R}\tilde\theta_\mu
   &&(\because\ \mathbb R\text{ の積の交換律}) \\
&= 2\pi j_{\mathbb R} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)
   &&(\because\ \mathbb R\text{ の差は加法の逆元の和})
\end{aligned}`,
      ),
      paragraph([
        "また、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を ",
        math(String.raw`(-(j_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}`),
        " に掛けたものを書き直す。主張と ",
        ref("exp_of_negative_i_real_as_cos_minus_i_sin"),
        " の ",
        math(String.raw`-i\theta_{\mathbb C}`),
        " も、この ",
        math(String.raw`-i`),
        " を掛けた ",
        math(String.raw`(-i)\,\theta_{\mathbb C}`),
        " の意味である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-i)\left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}
&= (-i)\left((-1_{\mathbb R})(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}
   &&(\because\ \mathbb R\text{ で }-x=(-1_{\mathbb R})x) \\
&= (-i)\left((-1_{\mathbb R})_{\mathbb C}\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \blkref{real_inclusion_preserves_product}) \\
&= (-i)\left((-1_{\mathbb C})\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&\bigl(\because\ (-1_{\mathbb R})_{\mathbb C}=(-1_{\mathbb R},0_{\mathbb R})\text{ は }1_{\mathbb C}\text{ の加法の逆元 }-1_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{definition_of_cc}\text{ の和},\ \blkref{complex_numbers_form_a_field})\bigr) \\
&= \left((-1_{\mathbb C})\,i\right)\left((-1_{\mathbb C})\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \blkref{multiply_by_minus_one}) \\
&= \left((-1_{\mathbb C})(-1_{\mathbb C})\right)\left(i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}) \\
&= 1_{\mathbb C}\left(i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ (-1_{\mathbb C})(-1_{\mathbb C})=1_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})) \\
&= i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}
   &&(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field}))
\end{aligned}`,
      ),
      paragraph(["これらを使って、主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i(j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu})_{\mathbb C})
&= \exp\!\left(-i\left(2\pi j_{\mathbb R} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)\right)_{\mathbb C}\right)
   &&(\because\ \text{準備の第一の鎖}) \\
&= \exp\!\left(-i\left((2\pi j_{\mathbb R})_{\mathbb C} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}\right)\right)
   &&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\text{ を }m=2,\ r_1=2\pi j_{\mathbb R},\ r_2=-(j_{\mathbb R}\tilde\theta_\mu)\text{ で。二項の有限和は }\blkref{def_finite_sum_of_complex_numbers}\text{ と }\mathbb R\text{ の有限和の定義で }r_1+r_2\text{ の形に開く}\bigr) \\
&= \exp\!\left((-i)(2\pi j_{\mathbb R})_{\mathbb C} + (-i)\left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}\right)
   &&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= \exp\!\left((-i)(2\pi j_{\mathbb R})_{\mathbb C} + i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \text{準備の第二の鎖}) \\
&= \exp((-i)(2\pi j_{\mathbb R})_{\mathbb C})\,\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で}) \\
&= \left((\cos(2\pi j_{\mathbb R}))_{\mathbb C} - i(\sin(2\pi j_{\mathbb R}))_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\text{ を }\theta=2\pi j_{\mathbb R}\text{ で}) \\
&= \left((1_{\mathbb R})_{\mathbb C} - i(\sin(2\pi j_{\mathbb R}))_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ j\in\mathbb Z\text{ と全実数上の }\cos(2\pi n_{\mathbb R})=1_{\mathbb R}) \\
&= \left((1_{\mathbb R})_{\mathbb C} - i(0_{\mathbb R})_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ j\in\mathbb Z\text{ と全実数上の }\sin(2\pi n_{\mathbb R})=0_{\mathbb R}) \\
&= \left(1_{\mathbb C} - i\cdot0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&\bigl(\because\ (1_{\mathbb R})_{\mathbb C}=(1_{\mathbb R},0_{\mathbb R})=1_{\mathbb C},\ (0_{\mathbb R})_{\mathbb C}=(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{complex_numbers_form_a_field}\text{ の単位元と零元})\bigr) \\
&= \left(1_{\mathbb C} - 0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{complex_times_zero_is_zero}) \\
&= \left(1_{\mathbb C} + (-0_{\mathbb C})\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{def_complex_difference}) \\
&= \left(1_{\mathbb C} + (-1_{\mathbb C})\,0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{multiply_by_minus_one}) \\
&= \left(1_{\mathbb C} + 0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{complex_times_zero_is_zero}) \\
&= 1_{\mathbb C}\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ 0_{\mathbb C}\text{ は和の単位元}\ (\blkref{complex_numbers_form_a_field})) \\
&= \exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field}))
\end{aligned}`,
      ),
      paragraph(["となる。"]),
      paragraph([
        "(3) ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        "（添字の周期性）を添字 ",
        math(String.raw`1-\mu \in \mathbb{Z}`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M_{\mathrm{col}}+1-\mu}
&=\check{Z}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Z}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkZ_periodicity}\bigr),\\[2pt]
\check{Y}_{M_{\mathrm{col}}+1-\mu}
&=\check{Y}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Y}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkY_periodicity}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "この適用では、添字の周期性を ", math(String.raw`\check{\mathcal{M}}`),
        " の外の添字 ", math(String.raw`1-\mu`),
        " に用いている。添字の周期性を ", math(String.raw`\mu\in\mathbb Z`),
        " で述べたことが、この橋渡しを可能にする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、二本の式変形鎖の行中にあった根拠 7 行を行末の根拠列（aligned の &&）へ揃え、添字の周期性の二本の等式を同じ形へ開いた。内容・式変形・根拠・ラベル参照は不変である。",
        "2026-11-03（全証明の SageMath 検算）: (2) の主張を像の記号 j_R・(·)_C で書き、全実数上の cos・sin の値を前提とすることを主張に書いた。(2) の証明は、主張と違う式を述べる euler_formula_cos_sin と行列の theorem_exp_product (n=1) を引いていたので、exp_of_negative_i_real_as_cos_minus_i_sin と scalar_exp_product に付け替え、包含の和・積の保存と符号の鎖を置いた。(1) の根拠「ℂ の四則」は実数の計算なので ℝ に直し、像の記号で書き直した。",
      ],
    },
  },
  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 9 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
        " と像の記号 ",
        math(String.raw`a_{\mathbb R}, a_{\mathbb C}`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check Z_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check Y_\mu`),
        " を用いる。",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`,
      ),
      paragraph([
        "が成り立つ。反交換子は ",
        ref("def_matrix_anticommutator"),
        " のもの、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})}`),
        " は単位行列である。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\nu,\ M_{\mathrm{col}}+1-\mu \in \check{\mathcal M} = \{1,\dots,M_{\mathrm{col}}\}`),
        " なので、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\in\mathbb C`),
        " は ",
        ref("def_kronecker_delta"),
        " のクロネッカーのデルタ（",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " のとき ",
        math(String.raw`1_{\mathbb C}`),
        "、そうでないとき ",
        math(String.raw`0_{\mathbb C}`),
        "）である。",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " は、",
        math(String.raw`2_{\mathbb C} := (2_{\mathbb R})_{\mathbb C}`),
        " と ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}`),
        " による複素数 ",
        math(String.raw`(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C})\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
        " による ",
        math(String.raw`I`),
        " のスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）を表し、",
        math(String.raw`0`),
        " は零行列 ",
        math(String.raw`O \in \mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})`),
        "（",
        ref("def_zero_matrix"),
        "）を表す。",
      ]),
      paragraph([
        "**対になる添字に合同式が現れない**のは、添字の範囲を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ったからである：",
        ref("def_check_index_set"),
        " (5) により ",
        math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
        " では ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        " と ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " が同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N}`),
        " と置き、",
        math(String.raw`j \in \{1,\dots,N\}`),
        "、",
        math(String.raw`\lambda \in \mathbb Z`),
        " について ",
        math(String.raw`e_{j,\lambda} := \exp(-i(j_{\mathbb R}\tilde\theta_\lambda)_{\mathbb C}) \in \mathbb C`),
        " と置く（",
        ref("def_half_integer_checkZ"),
        " の仮定により ",
        math(String.raw`\mathbb C`),
        " の元）。",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）であり、",
        math(String.raw`-i(x)_{\mathbb C}`),
        " は積 ",
        math(String.raw`(-i)(x)_{\mathbb C}`),
        " を表す。周期デルタ ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}`),
        "（",
        ref("def_delta_M"),
        "）の法は ",
        math(String.raw`N`),
        " である（",
        ref("antiperiodic_exp_sum"),
        "）。",
      ]),
      paragraph([
        "準備 1（添字の対角）。",
        math(String.raw`j, k \in \{1,\dots,N\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}, k_{\mathbb Z} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " である。",
        math(String.raw`j = k`),
        " なら ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z} = 0 = 0\cdot M_{\mathrm{col}}`),
        " なので ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})} = 1_{\mathbb C}`),
        "。",
        math(String.raw`j \neq k`),
        " なら、標準包含 ",
        math(String.raw`\iota_{\mathbb N\to\mathbb Z}`),
        " は単射なので ",
        math(String.raw`j_{\mathbb Z} \neq k_{\mathbb Z}`),
        "、さらに ",
        math(String.raw`0 < |j_{\mathbb Z} - k_{\mathbb Z}| \leq M_{\mathrm{col}} - 1 < M_{\mathrm{col}}`),
        " なので ",
        math(String.raw`M_{\mathrm{col}}`),
        " は ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z}`),
        " を割り切らず、",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})} = 0_{\mathbb C}`),
        "（",
        ref("def_delta_M"),
        "）。したがって ",
        math(String.raw`\lambda, \lambda' \in \mathbb Z`),
        "、",
        math(String.raw`j \neq k`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(e_{j,\lambda}e_{k,\lambda'})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}
&= (e_{j,\lambda}e_{k,\lambda'})\,0_{\mathbb C}
&&(\because\ \text{準備 1}) \\
&= 0_{\mathbb C}
&&(\because\ \blkref{complex_times_zero_is_zero})
\end{aligned}`,
      ),
      paragraph([
        "準備 2（指数）。",
        math(String.raw`\kappa := -(\mu+\nu-1) \in \mathbb Z`),
        " と置く。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。",
        math(String.raw`j \in \{1,\dots,N\}`),
        " について、実数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}\tilde\theta_\mu + j_{\mathbb R}\tilde\theta_\nu
&= j_{\mathbb R}\left(\tilde\theta_\mu + \tilde\theta_\nu\right)
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= j_{\mathbb R}\left(\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}} + \frac{2\pi\left(\nu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
&&\bigl(\because\ \tilde\theta\text{ の定義を 2 箇所へ同時適用。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right) + 2\pi\left(\nu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数の和}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}-\tfrac12\right) + \left(\nu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\left(-\tfrac12\right)\right)+\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の差は加法の逆元の和を 2 箇所へ同時適用}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\left(-\tfrac12\right)+\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の交換律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\nu_{\mathbb R}+\left(\left(-\tfrac12\right)+\left(-\tfrac12\right)\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(\left(-\tfrac12\right)+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(-\left(\tfrac12+\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }(-a)+(-b)=-(a+b)) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(-1_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \tfrac12+\tfrac12=1_{\mathbb R}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の差は加法の逆元の和}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(-\left(-\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }-(-x)=x) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(-\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和・零・単位元を保つので差と加法の逆元を保ち、}\kappa_{\mathbb R}=-\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)\text{。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{j_{\mathbb R}\left(2\pi\left(-\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a\cdot\tfrac{b}{c}=\tfrac{ab}{c}) \\
&= \frac{j_{\mathbb R}\left(-\left(2\pi\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a(-b)=-(ab)) \\
&= \frac{-\left(j_{\mathbb R}\left(2\pi\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a(-b)=-(ab)) \\
&= \frac{-\left(\left(j_{\mathbb R}\,2\pi\right)\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の積の結合律}) \\
&= \frac{-\left(\left(2\pi j_{\mathbb R}\right)\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の積の交換律}) \\
&= -\frac{2\pi j_{\mathbb R}\kappa_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }\tfrac{-a}{c}=-\tfrac{a}{c}\text{。}2\pi j_{\mathbb R}\kappa_{\mathbb R}:=\left(2\pi j_{\mathbb R}\right)\kappa_{\mathbb R})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`y_j := \frac{2\pi j_{\mathbb R}\kappa_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}} \in \mathbb R`),
        " と置くと、複素数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}
&= (-i)\left((j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= (-i)\left(j_{\mathbb R}\tilde\theta_\mu + j_{\mathbb R}\tilde\theta_\nu\right)_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\text{ を }m=2\text{ で。二項の有限和は }\blkref{def_finite_sum_of_complex_numbers}\text{ と }\mathbb R\text{ の有限和の定義で二項の和の形に開く}\bigr) \\
&= (-i)\left(-y_j\right)_{\mathbb C}
&&(\because\ \text{直前の実数の鎖}) \\
&= (-i)\left((-1_{\mathbb R})y_j\right)_{\mathbb C}
&&(\because\ \mathbb R\text{ で }-x=(-1_{\mathbb R})x) \\
&= (-i)\left((-1_{\mathbb R})_{\mathbb C}\,(y_j)_{\mathbb C}\right)
&&(\because\ \blkref{real_inclusion_preserves_product}) \\
&= (-i)\left((-1_{\mathbb C})\,(y_j)_{\mathbb C}\right)
&&\bigl(\because\ (-1_{\mathbb R})_{\mathbb C}=(-1_{\mathbb R},0_{\mathbb R})\text{ は }1_{\mathbb C}\text{ の加法の逆元 }-1_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{definition_of_cc}\text{ の和},\ \blkref{complex_numbers_form_a_field})\bigr) \\
&= \left((-1_{\mathbb C})\,i\right)\left((-1_{\mathbb C})\,(y_j)_{\mathbb C}\right)
&&(\because\ \blkref{multiply_by_minus_one}) \\
&= (-1_{\mathbb C})\left(i\left((-1_{\mathbb C})(y_j)_{\mathbb C}\right)\right)
&&(\because\ \mathbb C\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= (-1_{\mathbb C})\left(\left(i(-1_{\mathbb C})\right)(y_j)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= (-1_{\mathbb C})\left(\left((-1_{\mathbb C})i\right)(y_j)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の積の交換律。}\blkref{complex_numbers_form_a_field}) \\
&= (-1_{\mathbb C})\left((-1_{\mathbb C})\left(i\,(y_j)_{\mathbb C}\right)\right)
&&(\because\ \mathbb C\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= \left((-1_{\mathbb C})(-1_{\mathbb C})\right)\left(i\,(y_j)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= 1_{\mathbb C}\left(i\,(y_j)_{\mathbb C}\right)
&&(\because\ (-1_{\mathbb C})(-1_{\mathbb C})=1_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})) \\
&= i\,(y_j)_{\mathbb C}
&&(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field}))
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("exp_sum"),
        " は包含の像を書いていないが、その ",
        math(String.raw`M_{\mathrm{col}}\in\mathbb N_{\geq1}`),
        " を ",
        math(String.raw`N`),
        "、",
        math(String.raw`k\in\mathbb Z`),
        " を ",
        math(String.raw`\kappa`),
        " に取ったとき、左辺の指数 ",
        math(String.raw`\frac{2\pi i j \kappa}{N}`),
        " は ",
        math(String.raw`i\,(y_j)_{\mathbb C}`),
        "、右辺の係数 ",
        math(String.raw`N`),
        " は ",
        math(String.raw`N_{\mathbb C} = (M_{\mathrm{col}})_{\mathbb C}`),
        "（",
        math(String.raw`(N)_{\mathbb Z} = M_{\mathrm{col}}`),
        "。",
        ref("antiperiodic_exp_sum"),
        "）であり、右辺の積は ",
        math(String.raw`\mathbb C`),
        " の積である。",
      ]),
      paragraph([
        "第 1 式。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Z_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Z_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ}\text{ を 2 箇所へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} (e_{j,\mu}e_{k,\nu})\left[Z_{j_{\mathbb Z}}, Z_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} (e_{j,\mu}e_{k,\nu})\left(\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }2I\delta\text{ を、}2_{\mathbb C}I\text{ の }\delta\text{ 倍と書いた}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} \left((e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\left(\left(\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},j_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を各 }j\text{ へ }n = j\text{ で同時適用。}k\neq j\text{ の項は準備 1 の鎖で }0_{\mathbb C}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,1_{\mathbb C}\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 1 を各 }j\text{ へ同時適用}) \\
&= \left(\sum_{j=1}^{N}e_{j,\mu}e_{j,\nu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left((-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left(i\,(y_j)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 2 の複素数の鎖を各 }j\text{ へ同時適用}) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\kappa,\,0)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{exp_sum}\text{ を }N\text{ と }\kappa\text{ で。準備 2 の読み}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \kappa - 0 = -\left((\mu+\nu)-1\right)\text{ なので }\kappa\equiv0 \iff \mu+\nu\equiv1 \pmod{M_{\mathrm{col}}}\text{。}\blkref{def_delta_M}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{def_check_index_set}\ (5)\ (\mu,\nu \in \check{\mathcal{M}})\bigr) \\
&= \left(\left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)2_{\mathbb C}\right)I
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\bigr) \\
&= \left(\left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)I
   &&\bigl(\because \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり、最後の行は主張の右辺 ",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " である。",
      ]),
      paragraph(["第 2 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Z_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ},\ \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left[Z_{j_{\mathbb Z}},Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,O
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }0\text{ は零行列 }O\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}O
   &&\bigl(\because \blkref{scalar_multiple_of_zero_matrix}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}O
   &&\bigl(\because \blkref{finite_sum_of_zero_matrices}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= O
   &&\bigl(\because \blkref{finite_sum_of_zero_matrices}\bigr)
\end{aligned}`,
      ),
      paragraph(["第 3 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Y}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Y_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkY}\text{ を 2 箇所へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left[Y_{j_{\mathbb Z}},Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left(\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }2I\delta\text{ を、}2_{\mathbb C}I\text{ の }\delta\text{ 倍と書いた}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} \left((e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\left(\left(\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},j_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を各 }j\text{ へ }n = j\text{ で同時適用。}k\neq j\text{ の項は準備 1 の鎖で }0_{\mathbb C}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,1_{\mathbb C}\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 1 を各 }j\text{ へ同時適用}) \\
&= \left(\sum_{j=1}^{N}e_{j,\mu}e_{j,\nu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left((-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left(i\,(y_j)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 2 の複素数の鎖を各 }j\text{ へ同時適用}) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\kappa,\,0)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{exp_sum}\text{ を }N\text{ と }\kappa\text{ で。準備 2 の読み}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \kappa - 0 = -\left((\mu+\nu)-1\right)\text{ なので }\kappa\equiv0 \iff \mu+\nu\equiv1 \pmod{M_{\mathrm{col}}}\text{。}\blkref{def_delta_M}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{def_check_index_set}\ (5)\ (\mu,\nu \in \check{\mathcal{M}})\bigr) \\
&= \left(\left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)2_{\mathbb C}\right)I
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\bigr) \\
&= \left(\left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)I
   &&\bigl(\because \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり、最後の行は主張の右辺 ",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 主張に像の記号と、2M_col δ I・0 が何の元かを書いた（中身は不変）。証明は、名前だけの根拠「反交換子の ℂ 双線型性」を新しい主張 anticommutator_of_finite_sums_of_scalar_multiples・finite_sum_of_scalar_multiples_of_one_matrix への参照に、行列の theorem_exp_product (n=1) を scalar_exp_product に付け替え、二重和から j = k の項を残す段を準備 1 と finite_sum_with_single_nonzero_term に、θ̃_μ + θ̃_ν の書き換えと exp_sum の指数への読み替えを準備 2 の鎖に分け、第 3 式を省略せずに書いた。",
      ],
    },
  },
  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 10 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ から } Z_j, Y_j \text{ を復元する}` },
    labels: ["recover_Z_Y_from_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
        "、像の記号 ",
        math(String.raw`n_{\mathbb Z}, n_{\mathbb R}, a_{\mathbb R}, a_{\mathbb C}`),
        " と ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check Z_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check Y_\mu`),
        " を用いる。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " なので ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}=((M_{\mathrm{col}})_{\mathbb R},0_{\mathbb R})\neq(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）であり、その逆元 ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}^{-1}\in\mathbb C`),
        " がある（",
        ref("complex_numbers_form_a_field"),
        "）。",
        math(String.raw`j \in \{1,\dots,N\}`),
        " について",
      ]),
      displayMath(
        String.raw`(M_{\mathrm{col}})_{\mathbb C}^{-1}\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\check{Z}_{\mu_{\mathbb Z}} = Z_{j_{\mathbb Z}},
\qquad
(M_{\mathrm{col}})_{\mathbb C}^{-1}\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\check{Y}_{\mu_{\mathbb Z}} = Y_{j_{\mathbb Z}}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の ",
        math(String.raw`K=\mathbb C`),
        " のもの、",
        math(String.raw`i\,(x)_{\mathbb C}`),
        " は ",
        math(String.raw`\mathbb C`),
        " の積、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        " のものであり、両辺は ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " の元である。",
      ]),
      paragraph([
        "とくに、",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が、すべての ",
        math(String.raw`\mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`\check{Z}_{\mu_{\mathbb Z}}, \check{Y}_{\mu_{\mathbb Z}} \in T`),
        " を満たし、",
        ref("Z_Y_generate_algebra"),
        " の (ii)〜(iv)（単位行列を含み、和・スカラー倍・行列の積で閉じる）を満たすならば、",
        math(String.raw`T = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " である。すなわち ",
        math(String.raw`\check{Z}_{1_{\mathbb Z}},\dots,\check{Z}_{N_{\mathbb Z}},\check{Y}_{1_{\mathbb Z}},\dots,\check{Y}_{N_{\mathbb Z}}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " を単位的 ",
        math(String.raw`\mathbb{C}`),
        " 代数として生成する（",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " はこの ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " である）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`j, k, \mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`f_{j,\mu} := \exp(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}) \in \mathbb C`),
        "、",
        math(String.raw`e_{k,\mu} := \exp(-i(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}) \in \mathbb C`),
        "（",
        ref("def_scalar_exp"),
        "）と置き、",
        math(String.raw`c := (M_{\mathrm{col}})_{\mathbb C}^{-1} \in \mathbb C`),
        " と置く。",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）であり、",
        math(String.raw`-i(x)_{\mathbb C}`),
        " は積 ",
        math(String.raw`(-i)(x)_{\mathbb C}`),
        " を表す。",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " を ",
        math(String.raw`\mu_{\mathbb Z}\in\mathbb Z`),
        " で読むと、",
        math(String.raw`\check{Z}_{\mu_{\mathbb Z}} = \sum_{k=1}^{N} e_{k,\mu}Z_{k_{\mathbb Z}}`),
        "、",
        math(String.raw`\check{Y}_{\mu_{\mathbb Z}} = \sum_{k=1}^{N} e_{k,\mu}Y_{k_{\mathbb Z}}`),
        " である。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`k \neq j`),
        " の項）。",
        math(String.raw`j, k \in \{1,\dots,N\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}, k_{\mathbb Z} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " である。",
        math(String.raw`k \neq j`),
        " なら、標準包含 ",
        math(String.raw`\iota_{\mathbb N\to\mathbb Z}`),
        " は単射なので ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z} \neq 0`),
        "、さらに ",
        math(String.raw`|j_{\mathbb Z} - k_{\mathbb Z}| \leq M_{\mathrm{col}} - 1 < M_{\mathrm{col}}`),
        " である。したがって ",
        math(String.raw`A \in \mathrm{Mat}(2^{N},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{\mu=1}^{N}\exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)A
&= 0_{\mathbb C}\,A
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を }0<|j_{\mathbb Z}-k_{\mathbb Z}|<M_{\mathrm{col}}\text{ の整数 }j_{\mathbb Z}-k_{\mathbb Z}\text{ で}\bigr) \\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列）。",
      ]),
      paragraph([
        "準備 2（指数）。",
        math(String.raw`j, k, \mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`x := \tilde\theta_{\mu_{\mathbb Z}} \in \mathbb R`),
        " と置く。実数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}x + (-1_{\mathbb R})(k_{\mathbb R}x)
&= j_{\mathbb R}x + \left((-1_{\mathbb R})k_{\mathbb R}\right)x
&&(\because\ \mathbb R\text{ の積の結合律}) \\
&= j_{\mathbb R}x + \left(-k_{\mathbb R}\right)x
&&(\because\ \mathbb R\text{ で }(-1_{\mathbb R})y=-y) \\
&= \left(j_{\mathbb R} + \left(-k_{\mathbb R}\right)\right)x
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= \left(j_{\mathbb R} - k_{\mathbb R}\right)x
&&(\because\ \mathbb R\text{ の差は加法の逆元の和}) \\
&= (j_{\mathbb Z} - k_{\mathbb Z})_{\mathbb R}\,x
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので差を保つ。}j_{\mathbb R}=(j_{\mathbb Z})_{\mathbb R},\ k_{\mathbb R}=(k_{\mathbb Z})_{\mathbb R}\ (\blkref{antiperiodic_exp_sum})\bigr)
\end{aligned}`,
      ),
      paragraph(["であり、複素数の側で"]),
      displayMath(
        String.raw`\begin{aligned}
i\,(j_{\mathbb R}x)_{\mathbb C} + (-i)(k_{\mathbb R}x)_{\mathbb C}
&= i\,(j_{\mathbb R}x)_{\mathbb C} + \left((-1_{\mathbb C})\,i\right)(k_{\mathbb R}x)_{\mathbb C}
&&(\because\ \blkref{multiply_by_minus_one}) \\
&= i\,(j_{\mathbb R}x)_{\mathbb C} + \left(i\,(-1_{\mathbb C})\right)(k_{\mathbb R}x)_{\mathbb C}
&&(\because\ \mathbb C\text{ の積の交換律。}\blkref{complex_numbers_form_a_field}) \\
&= i\,(j_{\mathbb R}x)_{\mathbb C} + i\left((-1_{\mathbb C})(k_{\mathbb R}x)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= i\left((j_{\mathbb R}x)_{\mathbb C} + (-1_{\mathbb C})(k_{\mathbb R}x)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= i\left((j_{\mathbb R}x)_{\mathbb C} + (-1_{\mathbb R})_{\mathbb C}(k_{\mathbb R}x)_{\mathbb C}\right)
&&\bigl(\because\ (-1_{\mathbb R})_{\mathbb C}=(-1_{\mathbb R},0_{\mathbb R})\text{ は }1_{\mathbb C}\text{ の加法の逆元 }-1_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{definition_of_cc}\text{ の和},\ \blkref{complex_numbers_form_a_field})\bigr) \\
&= i\left((j_{\mathbb R}x)_{\mathbb C} + \left((-1_{\mathbb R})(k_{\mathbb R}x)\right)_{\mathbb C}\right)
&&(\because\ \blkref{real_inclusion_preserves_product}) \\
&= i\left(j_{\mathbb R}x + (-1_{\mathbb R})(k_{\mathbb R}x)\right)_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\text{ を }m=2\text{ で。二項の有限和は }\blkref{def_finite_sum_of_complex_numbers}\text{ と }\mathbb R\text{ の有限和の定義で二項の和の形に開く}\bigr) \\
&= i\left((j_{\mathbb Z} - k_{\mathbb Z})_{\mathbb R}\,x\right)_{\mathbb C}
&&(\because\ \text{直前の実数の鎖})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph(["第 1 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
c\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}}
&= c\sum_{\mu=1}^{N} f_{j,\mu}\left(\sum_{k=1}^{N} e_{k,\mu}Z_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{def_half_integer_checkZ}\text{ を }N\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} f_{j,\mu}\left(e_{k,\mu}Z_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を右辺から左辺へ、各 }\mu\text{ へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\sum_{\mu=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\ (r=s=N)\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }k\text{ へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C} + (-i)(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{k_{\mathbb Z}}
&&(\because\ \text{準備 2 の複素数の鎖を全ての }(k,\mu)\text{ へ同時適用}) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-j_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (q=j)\text{。}k\neq j\text{ の項は準備 1 の鎖（}A=Z_{k_{\mathbb Z}}\text{）で }O\bigr) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((0)_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{j_{\mathbb Z}}\right)
&&(\because\ \mathbb Z\text{ で }j_{\mathbb Z}-j_{\mathbb Z}=0) \\
&= c\left((M_{\mathrm{col}})_{\mathbb C}\,Z_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を整数 }0\text{ で}\bigr) \\
&= \left(c\,(M_{\mathrm{col}})_{\mathbb C}\right)Z_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr) \\
&= 1_{\mathbb C}\,Z_{j_{\mathbb Z}}
&&\bigl(\because\ c\text{ は }(M_{\mathrm{col}})_{\mathbb C}\text{ の逆元。}\blkref{complex_numbers_form_a_field}\bigr) \\
&= Z_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)
\end{aligned}`,
      ),
      paragraph(["第 2 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
c\sum_{\mu=1}^{N} f_{j,\mu}\check{Y}_{\mu_{\mathbb Z}}
&= c\sum_{\mu=1}^{N} f_{j,\mu}\left(\sum_{k=1}^{N} e_{k,\mu}Y_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{def_half_integer_checkY}\text{ を }N\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} f_{j,\mu}\left(e_{k,\mu}Y_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を右辺から左辺へ、各 }\mu\text{ へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\sum_{\mu=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\ (r=s=N)\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }k\text{ へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C} + (-i)(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{k_{\mathbb Z}}
&&(\because\ \text{準備 2 の複素数の鎖を全ての }(k,\mu)\text{ へ同時適用}) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-j_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (q=j)\text{。}k\neq j\text{ の項は準備 1 の鎖（}A=Y_{k_{\mathbb Z}}\text{）で }O\bigr) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((0)_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{j_{\mathbb Z}}\right)
&&(\because\ \mathbb Z\text{ で }j_{\mathbb Z}-j_{\mathbb Z}=0) \\
&= c\left((M_{\mathrm{col}})_{\mathbb C}\,Y_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を整数 }0\text{ で}\bigr) \\
&= \left(c\,(M_{\mathrm{col}})_{\mathbb C}\right)Y_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr) \\
&= 1_{\mathbb C}\,Y_{j_{\mathbb Z}}
&&\bigl(\because\ c\text{ は }(M_{\mathrm{col}})_{\mathbb C}\text{ の逆元。}\blkref{complex_numbers_form_a_field}\bigr) \\
&= Y_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "生成について。",
        math(String.raw`T`),
        " を主張の部分集合とし、",
        math(String.raw`j \in \{1,\dots,N\}`),
        " を取る。",
        ref("Z_Y_generate_algebra"),
        " の (iii) のスカラー倍により ",
        math(String.raw`f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        "、(iii) の和を ",
        ref("def_finite_sum_of_matrices"),
        " の帰納法の各段へ適用して ",
        math(String.raw`\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        "、もう一度 (iii) のスカラー倍により ",
        math(String.raw`c\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        " であり、第 1 式によりこれは ",
        math(String.raw`Z_{j_{\mathbb Z}}`),
        " である。同じく第 2 式により ",
        math(String.raw`Y_{j_{\mathbb Z}} \in T`),
        " である。",
        math(String.raw`1 \leq l \leq M_{\mathrm{col}}`),
        " の整数 ",
        math(String.raw`l`),
        " は ",
        math(String.raw`l = j_{\mathbb Z}`),
        " となる ",
        math(String.raw`j \in \{1,\dots,N\}`),
        " を持つ（",
        math(String.raw`N_{\mathbb Z} = M_{\mathrm{col}}`),
        "）ので、",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`S`),
        " について ",
        math(String.raw`S \subseteq T`),
        "、すなわち ",
        math(String.raw`T`),
        " は (i) も満たして閉じている。",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        " は閉じている部分集合のうち最小なので ",
        math(String.raw`\mathcal{A} \subseteq T`),
        " であり、",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " であるから ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C}) = \mathcal{A} \subseteq T \subseteq \mathrm{Mat}(2^{N},\mathbb{C})`),
        "、すなわち ",
        math(String.raw`T = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、復元式の鎖の最終行へスカラー 1/M と M の相殺という行末根拠を補った。内容は変えていない。",
        "2026-08-19 の式変形統一で、二つの displayMath と間の散文に分かれていた復元式の導出を、準備の指数和等式と一続き六段の鎖へまとめ、「Y_j についても同じ計算」と畳まれていた第 2 式を同じ形の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、準備の散文に埋まっていた j-k=0=0M を、整数の減法と乗法を一つずつ適用する二段の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 14 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・参照は変えていない。",
        "2026-11-03（全証明の SageMath 検算）: 主張に像の記号（j_Z・j_R・μ_Z）と (M_col)_C^{-1} の存在、exp・積・和の出所を書き、定義どおりスカラーを左に置いて主張の左辺から鎖を始める形にした（中身は不変）。生成の主張を Z_Y_generate_algebra の (i)〜(iv) で述べ直した。証明は、行列の theorem_exp_product (n=1) を scalar_exp_product に、名前だけの「有限和への分配」「有限和の順序交換」「k = j の項だけが残る」を finite_sum_of_scalar_multiples・新しい主張 finite_double_sum_of_matrices_interchange・finite_sum_of_matrices_with_single_nonzero_term に付け替え、指数の和を i((j_Z − k_Z)_R θ̃)_C へ書き換える準備 2 の鎖と、k ≠ j の項が O になる準備 1 の鎖を置いた。",
      ],
    },
  },
  {
    id: "Athetatilde_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 2 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ を対角化する道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " における ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " を対角化する。",
      ]),
      paragraph([
        "議論を支えるのは、すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とすべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が成り立つこと（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）である。したがって以下の主張はすべて**場合分けなし**で述べられる。",
      ]),
      paragraph([
        "さらに、固有値に現れる根号 ",
        math(String.raw`\sqrt{-\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}`),
        " は正の実数 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定する（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）。このため複素平方根の分枝を論じる必要がなく、固有値・固有ベクトルは代入して確かめるだけで得られる。",
        "また ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " の帰結として ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " が常に成り立ち、2 つの固有値は必ず分離する（",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: 章立ての組み直しで、旧い章「A(θ̃_μ) の対角化」の案内文をこの章の対角化の前へ移した。題を式で指すものにし、「この章」を「以下」に直し、「半整数運動量」の語と、ψ̌ の導入へ進まないとする段落（組み直した章では ψ̌ の導入まで続くので事実に合わない）を外した。",
      ],
    },
  },
  {
    id: "Athetatilde_001_definition_gamma1_gamma2",
    kind: "definition",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma_1(\theta), \gamma_2(\theta)\ (\theta \in \mathbb{R})` },
    labels: ["def_gamma1_gamma2_of_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`\theta \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) := c_1 c_2^* - s_1 s_2^*\cos\theta \in \mathbb{R},
\qquad
\gamma_2(\theta) := i\,\exp(i\theta) s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1 c_2\bigr) \in \mathbb{C}`,
      ),
      paragraph([
        "と定める。このとき ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " は",
      ]),
      displayMath(
        String.raw`A(\theta) = \begin{pmatrix}
\gamma_1(\theta) & \gamma_2(\theta) \\
-\gamma_2(-\theta) & \gamma_1(\theta)
\end{pmatrix}`,
      ),
      paragraph([
        "と書ける。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分は ",
        math(String.raw`c_1c_2^* - s_1s_2^*\cos\theta = \gamma_1(\theta)`),
        "、",
        math(String.raw`(1,2)`),
        " 成分は ",
        math(String.raw`i\exp(i\theta)s_2^*(c_1\cos\theta - i\sin\theta - s_1c_2) = \gamma_2(\theta)`),
        " であり、定義そのものである。",
      ]),
      paragraph([
        math(String.raw`(2,1)`),
        " 成分については、",
        math(String.raw`\cos(-\theta) = \cos\theta`),
        "、",
        math(String.raw`\sin(-\theta) = -\sin\theta`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,\exp(i(-\theta))s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
   \quad (\because \text{本ブロックの } \gamma_2 \text{ の定義式}) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
   \quad (\because i(-\theta)=-i\theta) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta - i\sin(-\theta) - s_1c_2\bigr)
   \quad (\because \cos(-\theta) = \cos\theta) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
   \quad (\because \sin(-\theta) = -\sin\theta)
\end{aligned}`,
      ),
      paragraph(["したがって ", ref("def_A_theta"), " の ", math(String.raw`(2,1)`), " 成分は"]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta)_{2,1}
&= -i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
   \quad (\because \blkref{def_A_theta}) \\
&= -\gamma_2(-\theta)
   \quad (\because \text{直前の }\gamma_2(-\theta)\text{ の式})
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の TV1_hatZ_hatY_020_definition_gamma1_gamma2 が同じ 2 つの量を θ_μ（整数運動量）に限って導入しているが、" +
          "そのブロックにはラベルが無く参照できない。半整数運動量 θ~_μ でも同じ式を使うので、ここで θ ∈ R の関数として" +
          "ラベル付きで定義し直した（式は 008 章のものと文字どおり同一。A(θ) 自体は def_A_theta を再定義していない）。",
      ],
    },
  },
  {
    id: "freeenergy_001_claim_gamma1_lower_bound_all_theta",
    kind: "claim",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma_1(\theta) \geq \cosh(2K_1 - 2K_2^*) \geq 1 \quad (\forall\theta\in\mathbb{R})` },
    labels: ["gamma1_lower_bound_all_theta"],
    statement: [
      paragraph([
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " を**すべての実数** ",
        math(String.raw`\theta`),
        " について考える。このとき",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) \geq \cosh\left(2K_1 - 2K_2^*\right) \geq 1
\qquad (\forall \theta \in \mathbb{R})`,
      ),
      paragraph([
        "が成り立つ。証明は全実数上の ",
        math(String.raw`\cos`),
        " の性質 ",
        math(String.raw`\cos\theta \leq 1\ (\theta \in \mathbb{R})`),
        " を前提とする（本文の ",
        ref("cosine_at_most_one"),
        " は ",
        math(String.raw`\theta \in [-\pi/2, \pi/2]`),
        " に限る）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " である。",
        ref("def_first_dual_coupling_constant"),
        "・",
        ref("def_second_dual_coupling_constant"),
        " より ",
        math(String.raw`K_1^*, K_2^* \in \mathbb{R}_{>0}`),
        " である。したがって ",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " より ",
        math(String.raw`c_1, s_1, c_2^*, s_2^* \in \mathbb{R}`),
        "、",
        math(String.raw`s_1 > 0`),
        "、",
        math(String.raw`s_2^* > 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1s_2^* &> 0\cdot s_2^*
&&(\because\ s_1>0\ \text{の両辺に}\ s_2^*>0\ \text{を掛ける})\\
&= 0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{との積は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "である。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\theta \leq 1
&\Longrightarrow s_1s_2^*\cos\theta \leq s_1s_2^*\cdot 1
&&(\because\ \text{両辺に}\ s_1s_2^*>0\ \text{を掛ける})\\
&\Longrightarrow -s_1s_2^*\cdot 1 \leq -s_1s_2^*\cos\theta
&&(\because\ \text{両辺に}\ -1<0\ \text{を掛ける。向きが変わる})
\end{aligned}`,
      ),
      paragraph([
        "であり、左端の ",
        math(String.raw`\cos\theta \leq 1`),
        " は主張の前提である。以下で ",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからであり、",
        math(String.raw`\cos\theta`),
        " が全実数上の実数値関数の値だからである。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&\geq c_1c_2^* - s_1s_2^*\cdot 1
&&(\because\ \text{準備の}\ -s_1s_2^*\cdot 1 \leq -s_1s_2^*\cos\theta\ \text{の両辺に}\ c_1c_2^*\ \text{を加える})\\
&= c_1c_2^* - s_1s_2^*
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元})\\
&= \cosh 2K_1\cosh 2K_2^* - \sinh 2K_1\sinh 2K_2^*
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= \cosh\left(2K_1-2K_2^*\right)
&&(\because\ \blkref{cosh_addition_formula}\ \text{の複号}\ -\ \text{を}\ x=2K_1,\ y=2K_2^*\ \text{に適用})\\
&\geq 1
&&(\because\ \blkref{cosh_at_least_one}\ \text{を}\ x=2K_1-2K_2^*\ \text{に適用})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。加法定理の適用と cosθ≤1 による評価が" +
          "散文で継がれた 2 つの表示に分かれていたのを、γ_1(θ) から 1 までの一続きの鎖にし、" +
          "根拠を行末の (∵ …) へ揃えた。引いていた根拠（加法定理・K_1,K_2^*>0・cosh≥1）は" +
          "すべて行末と直後の参照に残した。段は増えており、減った段は無い。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: statement の中で定めていた γ(θ) := arccosh(γ_1(θ))（θ∈ℝ）と、証明の末尾のその well-defined 性の文を、" +
          "独立した定義 def_gamma_theta へ移した（1 ブロック 1 主張）。不等式の主張と証明は変えていない。" +
          "γ_1 の出典を、γ_1 を定めていない def_A_theta から def_gamma1_gamma2_of_theta に直し、そのためにこのブロックを def_gamma1_gamma2_of_theta の直後へ移した。",
        "2026-11-03: SageMath の検算（sagemath/check/gamma1_lower_bound_all_theta/）に合わせて根拠を各行から引く形にした。" +
          "s_1, s_2^* > 0 の出典を双対結合定数の正値性と indexed_hyperbolic_abbreviations_positive に、s_1s_2^* > 0 を鎖に、" +
          "略記を双曲線関数へ戻す行を def_indexed_hyperbolic_abbreviations で足し、名前だけの「加法定理」「cosh は 1 以上」を " +
          "cosh_addition_formula・cosh_at_least_one への参照にし、末尾の参照の一覧を外した。cos θ ≤ 1 による評価を準備の一操作ずつの含意に分け、" +
          "全実数上の cos の性質 cos θ ≤ 1 を前提とすることを主張に書いた（不等式の中身は変えていない）。",
      ],
    },
  },
  {
    id: "Athetatilde_001b_definition_gamma_theta",
    kind: "definition",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma(\theta)\ (\theta \in \mathbb{R}) \text{ の定義}` },
    labels: ["def_gamma_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`\theta \in \mathbb{R}`),
        " について ",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta \in \mathbb{R}`),
        " を考える。",
        ref("gamma1_lower_bound_all_theta"),
        " より ",
        math(String.raw`\gamma_1(\theta) \geq 1`),
        " であり、",
      ]),
      displayMath(
        String.raw`\gamma(\theta) := \mathrm{arccosh}\left(\gamma_1(\theta)\right) \in \mathbb{R}_{\geq 0}`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\mathrm{arccosh}(y)`),
        "（",
        math(String.raw`y \geq 1`),
        "）は ",
        math(String.raw`\cosh t = y`),
        " を満たす唯一の ",
        math(String.raw`t \in \mathbb{R}_{\geq 0}`),
        " である（",
        ref("def_arccosh"),
        "、",
        ref("arccosh_properties"),
        " (1)–(3)）。とくに ",
        math(String.raw`\cosh\gamma(\theta) = \gamma_1(\theta)`),
        " である（",
        ref("arccosh_properties"),
        " (2)）。",
      ]),
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）であり、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " はこの ",
        math(String.raw`\gamma`),
        " の ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " での値を表す。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: gamma1_lower_bound_all_theta の statement の中で定めていた γ(θ) := arccosh(γ_1(θ))（θ∈ℝ）と、" +
          "旧ラベル def_gamma_theta_tilde_mu の γ(θ~_μ) := arccosh(γ_1(θ~_μ)) を、この一つの定義へまとめた（1 ブロック 1 主張）。" +
          "そのブロックには γ(θ~_μ) > 0 の主張だけを残し、ラベルを gamma_theta_tilde_mu_positive に改めた。式は両者のものと文字どおり同一である。",
      ],
    },
  },
  {
    id: "Athetatilde_002_claim_gamma2_nonzero",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 4 },
    title: { tex: String.raw`\gamma_2(\tilde\theta_\mu) \neq 0 \text{（例外なし）}` },
    labels: ["gamma_2_theta_tilde_nonzero"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " について、**すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " と、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について**",
      ]),
      displayMath(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。", math(String.raw`\gamma_2(-\tilde\theta_\mu)`), " の非零性は、後で共役関係から導く。"]),
    ],
    proof: [
      paragraph([
        "Step 0（正値性）。",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " から、",
        ref("def_first_dual_coupling_constant"),
        "・",
        ref("def_second_dual_coupling_constant"),
        "・",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " により次が従う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&K_1^* \in \mathbb{R}_{>0}
   \quad (\because\ \blkref{def_first_dual_coupling_constant}\text{ と }K_1 \in \mathbb{R}_{>0}) \\
&K_2^* \in \mathbb{R}_{>0}
   \quad (\because\ \blkref{def_second_dual_coupling_constant}\text{ と }K_2 \in \mathbb{R}_{>0}) \\
&c_1 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=1\text{ に適用。}K_1 \in \mathbb{R}_{>0}) \\
&s_1 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=1\text{ に適用。}K_1 \in \mathbb{R}_{>0}) \\
&c_2 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=2\text{ に適用。}K_2 \in \mathbb{R}_{>0}) \\
&s_2^* > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=2\text{ に適用。}K_2^* \in \mathbb{R}_{>0})
\end{aligned}`,
      ),
      paragraph([
        "Step 1（零点の必要条件）。",
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_gamma1_gamma2_of_theta"),
        " の定義式の実数 ",
        math(String.raw`c_1, s_1, c_2, s_2^*, \cos\theta, \sin\theta`),
        " を ",
        ref("inclusion_rr_to_cc"),
        " の像として読み、次の三つの複素数を置く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta) &:= i\,\exp(i\theta)\,(s_2^*)_{\mathbb{C}} \in \mathbb{C}, \\
b(\theta) &:= (-i)\,\exp(-i\theta)\,\bigl((s_2^*)^{-1}\bigr)_{\mathbb{C}} \in \mathbb{C}, \\
w(\theta) &:= (c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i\,(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}} \in \mathbb{C}
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`(s_2^*)^{-1} \in \mathbb{R}`),
        " は Step 0 の ",
        math(String.raw`s_2^* > 0`),
        " から定まる。）まず ",
        math(String.raw`w(\theta)`),
        " の成分を求めておく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w(\theta)
&= (c_1,0)(\cos\theta,0) + (-1,0)\bigl((0,1)(\sin\theta,0)\bigr) + (-1,0)\bigl((s_1,0)(c_2,0)\bigr)
   \quad (\because w(\theta)\text{ の定義、}\blkref{inclusion_rr_to_cc}\text{、}i = (0,1)\text{、}\blkref{def_complex_difference}\text{、}\blkref{multiply_by_minus_one}) \\
&= (c_1\cos\theta, 0) + (-1,0)(0, \sin\theta) + (-1,0)(s_1c_2, 0)
   \quad (\because \blkref{definition_of_cc}\text{ の積を三か所に}) \\
&= (c_1\cos\theta, 0) + (0, -\sin\theta) + (-s_1c_2, 0)
   \quad (\because \blkref{definition_of_cc}\text{ の積を二か所に}) \\
&= (c_1\cos\theta - s_1c_2,\ -\sin\theta)
   \quad (\because \blkref{definition_of_cc}\text{ の和})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`b(\theta)`),
        " は ",
        math(String.raw`a(\theta)`),
        " の逆元である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta)\,b(\theta)
&= \bigl(i\,\exp(i\theta)\,(s_2^*)_{\mathbb{C}}\bigr)\bigl((-i)\,\exp(-i\theta)\,((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because a(\theta), b(\theta) \text{ の定義}) \\
&= \bigl(i(-i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \mathbb{C} \text{ の積の結合律と可換律。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl(i\,((-1_{\mathbb{C}})\,i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{multiply_by_minus_one}\text{ の } -i := (-1_{\mathbb{C}})\,i) \\
&= \bigl((-1_{\mathbb{C}})(i\,i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \mathbb{C} \text{ の積の結合律と可換律。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{definition_of_cc}\text{ の積で } (0,1)(0,1) = (-1,0)) \\
&= 1_{\mathbb{C}}\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{definition_of_cc}\text{ の積で } (-1,0)(-1,0) = (1,0)) \\
&= 1_{\mathbb{C}}\exp\bigl(i\theta + (-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{scalar_exp_product}\text{ を }K = \mathbb{C}\text{ で}) \\
&= 1_{\mathbb{C}}\exp(0_{\mathbb{C}})\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because i\theta + (-i\theta) = 0_{\mathbb{C}}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{scalar_exp_zero}\text{ を }K = \mathbb{C}\text{ で}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}\bigl(s_2^*(s_2^*)^{-1}\bigr)_{\mathbb{C}}
   \quad (\because \blkref{real_inclusion_preserves_product}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}(1)_{\mathbb{C}}
   \quad (\because s_2^*(s_2^*)^{-1} = 1) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}1_{\mathbb{C}}
   \quad (\because \blkref{inclusion_rr_to_cc}\text{ の略記 } 1_{\mathbb{C}} = (1)_{\mathbb{C}}) \\
&= 1_{\mathbb{C}}
   \quad (\because 1_{\mathbb{C}} \text{ は積の単位元。}\blkref{complex_numbers_form_a_field})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`a(\theta) \neq 0_{\mathbb{C}}`),
        " である。実際 ",
        math(String.raw`a(\theta) = 0_{\mathbb{C}}`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}
&= a(\theta)\,b(\theta)
   \quad (\because \text{直前の鎖}) \\
&= 0_{\mathbb{C}}\,b(\theta)
   \quad (\because \text{仮定 } a(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph([
        "となり、",
        math(String.raw`1_{\mathbb{C}} \neq 0_{\mathbb{C}}`),
        "（",
        ref("complex_numbers_form_a_field"),
        "）に反する。",
        math(String.raw`a(\theta)\,w(\theta) = 0_{\mathbb{C}}`),
        " と ",
        math(String.raw`w(\theta) = 0_{\mathbb{C}}`),
        " は同値である。前者を仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w(\theta)
&= 1_{\mathbb{C}}\,w(\theta)
   \quad (\because 1_{\mathbb{C}} \text{ は積の単位元。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl(b(\theta)\,a(\theta)\bigr)\,w(\theta)
   \quad (\because \text{逆元の鎖と積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= b(\theta)\,\bigl(a(\theta)\,w(\theta)\bigr)
   \quad (\because \text{積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= b(\theta)\,0_{\mathbb{C}}
   \quad (\because \text{仮定 } a(\theta)\,w(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}\,b(\theta)
   \quad (\because \text{積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph(["であり、後者を仮定すると"]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta)\,w(\theta)
&= a(\theta)\,0_{\mathbb{C}}
   \quad (\because \text{仮定 } w(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}\,a(\theta)
   \quad (\because \text{積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta) = 0_{\mathbb{C}}
&\iff a(\theta)\,w(\theta) = 0_{\mathbb{C}}
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ の定義式を積の結合律で括り直す}) \\
&\iff w(\theta) = 0_{\mathbb{C}}
   \quad (\because \text{直前の二つの鎖}) \\
&\iff \bigl(c_1\cos\theta - s_1c_2,\ -\sin\theta\bigr) = (0, 0)
   \quad (\because \text{準備の } w(\theta) \text{ の成分の鎖と、}\blkref{inclusion_rr_to_cc}\text{ の } 0_{\mathbb{C}} = (0,0)) \\
&\iff \begin{cases} c_1\cos\theta - s_1c_2 = 0 \\ -\sin\theta = 0 \end{cases}
   \quad (\because \mathbf{R}^2 \text{ の元の相等は成分ごと}) \\
&\iff \begin{cases} c_1\cos\theta = s_1c_2 \\ -\sin\theta = 0 \end{cases}
   \quad (\because \text{第 1 式の両辺に } s_1c_2 \text{ を加える}) \\
&\iff \begin{cases} c_1\cos\theta = s_1c_2 \\ \sin\theta = 0 \end{cases}
   \quad (\because \text{第 2 式の両辺を } -1 \text{ 倍する})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\sin\tilde\theta_\mu = 0`),
        " が要求すること）。",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " とする。実数 ",
        math(String.raw`t`),
        " に対する ",
        math(String.raw`\sin t = 0 \iff \exists k\in\mathbb{Z}: t = k\pi`),
        " と ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sin\tilde\theta_\mu = 0
&\iff \exists k \in \mathbb{Z}:\ \tilde\theta_\mu = k\pi
   \quad (\because \sin t = 0 \iff \exists k \in \mathbb{Z}:\ t = k\pi) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}} = k\pi
   \quad (\because \blkref{antiperiodic_exp_sum}\text{ の定義}) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\left(\mu-\frac12\right)}{M_{\mathrm{col}}} = k
   \quad (\because \text{両辺を } \pi > 0 \text{ で割る}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\left(\mu - \tfrac12\right) = kM_{\mathrm{col}}
   \quad (\because \text{両辺を } M_{\mathrm{col}} \neq 0 \text{ 倍する}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\mu - 1 = kM_{\mathrm{col}}
   \quad (\because \text{分配則 } 2\left(\mu-\tfrac12\right) = 2\mu - 1)
\end{aligned}`,
      ),
      paragraph([
        "このとき ",
        math(String.raw`k`),
        " は奇数である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&2\mu - 1 = kM_{\mathrm{col}} \\
&\Longrightarrow kM_{\mathrm{col}} = 2(\mu-1) + 1
   \quad (\because 2\mu - 1 = 2(\mu-1) + 1,\ \mu - 1 \in \mathbb{Z}) \\
&\Longrightarrow kM_{\mathrm{col}} \text{ は奇数}
   \quad (\because \text{奇数の定義}) \\
&\Longrightarrow k \text{ は奇数}
   \quad (\because \text{整数は偶数か奇数のどちらか一方で、} k = 2l\ (l \in \mathbb{Z}) \text{ なら } kM_{\mathrm{col}} = 2(lM_{\mathrm{col}}) \text{ は偶数})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（そのとき ",
        math(String.raw`\cos\tilde\theta_\mu = -1`),
        "）。Step 2 の ",
        math(String.raw`\tilde\theta_\mu = k\pi`),
        " と ",
        math(String.raw`k`),
        " が奇数であることから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\tilde\theta_\mu
&= \cos(k\pi)
   \quad (\because \text{Step 2 の } \tilde\theta_\mu = k\pi) \\
&= (-1)^{k}
   \quad (\because k \in \mathbb{Z} \text{ に対し } \cos(k\pi) = (-1)^k) \\
&= -1
   \quad (\because \text{Step 2 より } k \text{ は奇数})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（矛盾）。Step 1 の連立条件の第 1 式に Step 3 を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1c_2
&= c_1\cos\tilde\theta_\mu
   \quad (\because \text{Step 1 の連立条件の第 1 式}) \\
&= c_1\cdot(-1)
   \quad (\because \text{Step 3 の } \cos\tilde\theta_\mu = -1) \\
&= -c_1
   \quad (\because \mathbb{R} \text{ の積の符号規則 } a\cdot(-1) = -a)
\end{aligned}`,
      ),
      paragraph([
        "が要求される。これは Step 0 に反する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&< s_1c_2
   \quad (\because \text{Step 0 の } s_1 > 0,\ c_2 > 0 \text{ と正数の積}) \\
&= -c_1
   \quad (\because \text{直前の鎖}) \\
&< 0
   \quad (\because \text{Step 0 の } c_1 > 0)
\end{aligned}`,
      ),
      paragraph([
        "は ",
        math(String.raw`0 < 0`),
        " を導き、矛盾である。よって Step 1 の連立条件は ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " で成り立たず、",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "M = 2..8 の全 μ、および厳密な臨界点 sinh 2K_1 sinh 2K_2 = 1 とその近傍を含む 16 組の (K_1,K_2) で数値確認済み。" +
          "半整数運動量側の |γ_2(θ~_μ)| の最小値は 1.6e-1 で 0 から離れている一方、同じ K で整数運動量 θ = 2π では " +
          "臨界点ちょうどのとき |γ_2| ~ 1e-16（＝0）になる（sagemath/check/048_claim_A_theta_tilde/check_01）。",
        "sin θ~_μ = 0 となる (M, μ) は M が奇数のときの (2μ−1)/M が奇数の場合に限られ（μ ∈ {1,…,M} では k = 1 のみ）、" +
          "そこでは常に cos θ~_μ = −1 であることも M ≤ 40 の全探索で確認した（同 check_01 の (c)）。",
        "2026-08-19 の式変形統一で、Step 1・Step 2 の鎖の行末根拠をラベル識別子の生文字列から人間可読な名前へ直し、" +
          "Step 2 の「両辺を π で割って M 倍する」を一操作ずつの二行に分け、最終行（2(μ−1/2) = 2μ−1）に" +
          "行末根拠を補って鎖の後の重複した散文根拠を外した。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。" +
          "Step 0 の正値性は第一・第二の双対結合定数の定義と添字つき略記の正値性から直接導く形に改めた。",
      ],
    },
  },
  {
    id: "Athetatilde_003_claim_relation_of_gamma2",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 5 },
    title: {
      tex: String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)} \text{ とその帰結}`,
    },
    labels: ["relation_of_gamma_2_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\text{(1)}\quad \gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)},
\qquad
\text{(2)}\quad \gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)
= -\left|\gamma_2(\tilde\theta_\mu)\right|^2 < 0`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)`),
        " は**負の実数**であり（",
        ref("gamma_2_theta_tilde_nonzero"),
        " より狭義に負）、",
      ]),
      displayMath(
        String.raw`\text{(3)}\quad \arg^{[0,2\pi)}\!\left(\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)\right) = \pi,
\qquad
\text{(4)}\quad \sqrt{-\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= \left|\gamma_2(\tilde\theta_\mu)\right| > 0`,
      ),
      displayMath(
        String.raw`\text{(5)}\quad \sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= i\left|\gamma_2(\tilde\theta_\mu)\right|`,
      ),
      paragraph([
        "も成り立つ（",
        math(String.raw`\sqrt{\ }`),
        " は ",
        ref("def_sqrt_cc"),
        " の、偏角を ",
        math(String.raw`[0,2\pi)`),
        " で取る一価の写像）。また ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) \neq 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta := \tilde\theta_\mu`),
        " と略記する。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\theta \in \mathbb{R}`),
        " であり、以下の共役の計算はこの実数性を使う。",
        math(String.raw`c_1, c_2, s_1, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        "、",
        math(String.raw`\cos\theta, \sin\theta, \cos(-\theta), \sin(-\theta) \in \mathbb{R}`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値である（全実数上への拡張は未整備）。これらの実数が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは、",
        ref("def_gamma1_gamma2_of_theta"),
        " の書き方に従い ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`r_{\mathbb{C}}`),
        " として読み、像の記号を省く。",
        math(String.raw`r, r' \in \mathbb{R}`),
        " について ",
        math(String.raw`r_{\mathbb{C}}r'_{\mathbb{C}} = (rr')_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_product"),
        "）なので、",
        math(String.raw`c_1\cos\theta`),
        "・",
        math(String.raw`s_1c_2`),
        " も実数の像である。複素共役は ",
        ref("def_complex_conjugate"),
        "、",
        math(String.raw`-z`),
        " は ",
        ref("multiply_by_minus_one"),
        "、差は ",
        ref("def_complex_difference"),
        " のものとする。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\cos(-\theta)`),
        "・",
        math(String.raw`\sin(-\theta)`),
        "・",
        math(String.raw`\exp(i\theta)`),
        " を ",
        math(String.raw`\exp(\pm i\theta)`),
        " で書く（",
        math(String.raw`-\theta \in \mathbb{R}`),
        " なので ",
        ref("euler_formula_cos_sin"),
        " を ",
        math(String.raw`-\theta`),
        " にも適用できる）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos(-\theta)
&= \frac{\exp(i(-\theta)) + \exp(-i(-\theta))}{2}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{を}\ -\theta\ \text{に適用})\\
&= \frac{\exp(-i\theta) + \exp(i\theta)}{2}
&&(\because\ \mathbb{C}\ \text{の四則}\ i(-\theta) = -i\theta,\ -i(-\theta) = i\theta)\\
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2}
&&(\because\ \mathbb{C}\ \text{の和の可換律})\\
&= \cos\theta
&&(\because\ \blkref{euler_formula_cos_sin})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sin(-\theta)
&= \frac{\exp(i(-\theta)) - \exp(-i(-\theta))}{2i}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{を}\ -\theta\ \text{に適用})\\
&= \frac{\exp(-i\theta) - \exp(i\theta)}{2i}
&&(\because\ \mathbb{C}\ \text{の四則}\ i(-\theta) = -i\theta,\ -i(-\theta) = i\theta)\\
&= -\frac{\exp(i\theta) - \exp(-i\theta)}{2i}
&&(\because\ \mathbb{C}\ \text{の四則})\\
&= -\sin\theta
&&(\because\ \blkref{euler_formula_cos_sin})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cos\theta + i\sin\theta
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + i\,\frac{\exp(i\theta) - \exp(-i\theta)}{2i}
&&(\because\ \blkref{euler_formula_cos_sin})\\
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + \frac{\exp(i\theta) - \exp(-i\theta)}{2}
&&(\because\ \mathbb{C}\ \text{の四則}\ i/(2i) = 1/2)\\
&= \exp(i\theta)
&&(\because\ \mathbb{C}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "第二に、",
        math(String.raw`i = (0,1)`),
        "（",
        ref("antiperiodic_exp_sum"),
        " の前置きの ",
        math(String.raw`i`),
        "）の複素共役と、",
        math(String.raw`\exp(i\theta)`),
        " の複素共役を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bar i
&= \overline{(0,1)}
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= (0,-1)
&&(\because\ \blkref{def_complex_conjugate})\\
&= (-1,0)(0,1)
&&(\because\ \blkref{definition_of_cc}\ \text{の積}\ ((-1)\cdot 0 - 0\cdot 1,\ (-1)\cdot 1 + 0\cdot 0))\\
&= (-1_{\mathbb{C}})(0,1)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (-1)_{\mathbb{C}} = (-1,0))\\
&= (-1_{\mathbb{C}})\,i
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= -i
&&(\because\ \blkref{multiply_by_minus_one})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{\exp(i\theta)}
&= \overline{\cos\theta + i\sin\theta}
&&(\because\ \text{上の}\ \exp(i\theta)\ \text{の表示})\\
&= \overline{\cos\theta} + \overline{i\sin\theta}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{を}\ m = 2\ \text{で})\\
&= \overline{\cos\theta} + \bar i\;\overline{\sin\theta}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \cos\theta + \bar i\sin\theta
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を 2 箇所へ})\\
&= \cos\theta + (-i)\sin\theta
&&(\because\ \text{上の}\ \bar i = -i)\\
&= \cos\theta - i\sin\theta
&&(\because\ \mathbb{C}\ \text{の四則})\\
&= \exp(-i\theta)
&&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin})
\end{aligned}`),
      paragraph([
        "第三に、",
        math(String.raw`\gamma_2(-\theta)`),
        " を ",
        math(String.raw`\theta`),
        " の量で書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,\exp(i(-\theta))\,s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{を}\ -\theta \in \mathbb{R}\ \text{に適用})\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \mathbb{C}\ \text{の四則}\ i(-\theta) = -i\theta)\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \text{上の}\ \cos(-\theta) = \cos\theta)\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - i(-\sin\theta) - s_1c_2\bigr)
&&(\because\ \text{上の}\ \sin(-\theta) = -\sin\theta)\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&(\because\ \mathbb{C}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "第四に、",
        math(String.raw`\overline{\gamma_2(\theta)}`),
        " を 1 段ずつ計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\gamma_2(\theta)}
&= \overline{i\,\exp(i\theta)\,s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= \overline{i\,\exp(i\theta)\,s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \overline{i\,\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \bar i\;\overline{\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= (-i)\;\overline{\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \text{上の}\ \bar i = -i)\\
&= (-i)\,\exp(-i\theta)\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \text{上の}\ \overline{\exp(i\theta)} = \exp(-i\theta))\\
&= (-i)\,\exp(-i\theta)\,s_2^*\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta - i\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_difference})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta} - \overline{i\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_difference})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta} - \bar i\;\overline{\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - \bar i\sin\theta - s_1c_2\bigr)
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を 3 箇所へ})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - (-i)\sin\theta - s_1c_2\bigr)
&&(\because\ \text{上の}\ \bar i = -i)\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&(\because\ \mathbb{C}\ \text{の四則})\\
&= -\Bigl(i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)\Bigr)
&&(\because\ \mathbb{C}\ \text{の四則})\\
&= -\gamma_2(-\theta)
&&(\because\ \text{上の}\ \gamma_2(-\theta)\ \text{の表示})
\end{aligned}`),
      paragraph([
        "第五に、",
        math(String.raw`\arctan 0 = 0`),
        "・",
        math(String.raw`\sin(\pi/2) = 1`),
        "・",
        math(String.raw`\cos(\pi/2) = 0`),
        "・",
        math(String.raw`0 < \pi`),
        " を確かめる。",
        math(String.raw`\pi`),
        " は ",
        math(String.raw`\arcsin(1) = \pi/2`),
        " となる実数である（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の円周率の項。",
        math(String.raw`\pi \in \mathbb{R}`),
        " を使うのは、弧の長さが実数だからである）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\arctan 0
&= \arcsin\!\left(\frac{0}{\sqrt{1+0^2}^{(\mathbb{R}_{\geq 0})}}\right)
&&(\because\ \blkref{def_arctan})\\
&= \arcsin(0)
&&(\because\ \mathbb{R}\ \text{の四則}\ 0/\sqrt{1}^{(\mathbb{R}_{\geq 0})} = 0)\\
&= \arcsin(\sin 0)
&&(\because\ \blkref{sine_zero})\\
&= 0
&&(\because\ \blkref{def_sin}\ \text{を}\ 0 \in [-\pi/2,\pi/2]\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sin(\pi/2)
&= \sin(\arcsin(1))
&&(\because\ \blkref{remark_real_analysis_facts_R3_R4}\ \text{の}\ \arcsin(1) = \pi/2)\\
&= 1
&&(\because\ \pi/2 = \arcsin(1) \in [-\pi/2,\pi/2]\ (\blkref{arcsin_is_bijection}\ \text{の値域})\ \text{で}\ \blkref{def_sin}\ \text{の}\ y\ \text{はただ一つ。}\arcsin(1) = \pi/2\ \text{なので}\ y = 1)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cos(\pi/2)
&= \sqrt{1-(\sin(\pi/2))^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \blkref{def_cos})\\
&= \sqrt{1-1^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \text{上の}\ \sin(\pi/2) = 1)\\
&= \sqrt{0}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 0
&&(\because\ 0 \geq 0\ \text{かつ}\ 0^2 = 0\ \text{なので、}\blkref{definition_of_sqrt_r_positive}\ \text{のただ一つの元は}\ 0)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\pi
&= 2\arcsin(1)
&&(\because\ \blkref{remark_real_analysis_facts_R3_R4}\ \text{の}\ \arcsin(1) = \pi/2)\\
&> 2\arcsin(0)
&&(\because\ 0 < 1\ \text{と}\ \blkref{arcsin_is_bijection}\ \text{の狭義単調増加})\\
&= 2\cdot 0
&&(\because\ \text{上の鎖の}\ \arcsin(0) = 0)\\
&= 0
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "とくに ",
        math(String.raw`0 \leq 0 - 2\cdot 0\cdot\pi < 2\pi`),
        " と ",
        math(String.raw`0 \leq \pi - 2\cdot 0\cdot\pi < 2\pi`),
        " が成り立つので、",
        ref("angle_section_existence_uniqueness"),
        " の整数は角度 ",
        math(String.raw`0`),
        " と ",
        math(String.raw`\pi`),
        " のどちらについても ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        "(1) 主張 (1) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= -\bigl(-\gamma_2(-\theta)\bigr)
&&(\because\ \mathbb{C}\ \text{の四則}\ (-1_{\mathbb{C}})(-1_{\mathbb{C}}) = 1_{\mathbb{C}})\\
&= -\overline{\gamma_2(\theta)}
&&(\because\ \text{上の}\ \overline{\gamma_2(\theta)} = -\gamma_2(-\theta))
\end{aligned}`),
      paragraph([
        "(2) 主張 (2) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \gamma_2(\theta)\left(-\overline{\gamma_2(\theta)}\right)
&&(\because\ (1))\\
&= \gamma_2(\theta)\left((-1_{\mathbb{C}})\,\overline{\gamma_2(\theta)}\right)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \left(\gamma_2(\theta)(-1_{\mathbb{C}})\right)\overline{\gamma_2(\theta)}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \left((-1_{\mathbb{C}})\,\gamma_2(\theta)\right)\overline{\gamma_2(\theta)}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (-1_{\mathbb{C}})\left(\gamma_2(\theta)\,\overline{\gamma_2(\theta)}\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (-1_{\mathbb{C}})\left(\overline{\gamma_2(\theta)}\,\gamma_2(\theta)\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (-1_{\mathbb{C}})\left(\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&(\because\ \blkref{complex_conjugate_times_self})\\
&= \left((-1)\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \left(-\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "主張 (2) の右辺 ",
        math(String.raw`-|\gamma_2(\theta)|^2`),
        " はこの実数の像として読む。この実数が負であることを示す。",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`|\gamma_2(\theta)| \in \mathbb{R}_{\geq 0}`),
        "、",
        ref("gamma_2_theta_tilde_nonzero"),
        " の ",
        math(String.raw`\gamma_2(\theta) \neq 0_{\mathbb{C}}`),
        " と ",
        ref("abs_basic_properties"),
        " (3) より ",
        math(String.raw`|\gamma_2(\theta)| \neq 0`),
        " なので、",
        math(String.raw`|\gamma_2(\theta)| > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&= 0\cdot\left|\gamma_2(\theta)\right|
&&(\because\ \mathbb{R}\ \text{の四則})\\
&< \left|\gamma_2(\theta)\right|\left|\gamma_2(\theta)\right|
&&(\because\ 0 < \left|\gamma_2(\theta)\right|\ \text{の両辺に正の実数}\ \left|\gamma_2(\theta)\right|\ \text{を掛ける})\\
&= \left|\gamma_2(\theta)\right|^2
&&(\because\ \text{実数の 2 乗の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\left|\gamma_2(\theta)\right|^2
&< -0
&&(\because\ \text{直前の鎖の}\ 0 < \left|\gamma_2(\theta)\right|^2\ \text{の両辺を}\ -1\ \text{倍すると向きが変わる})\\
&= 0
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        math(String.raw`\gamma_2(-\theta) \neq 0_{\mathbb{C}}`),
        " を背理法で示す。",
        math(String.raw`\gamma_2(-\theta) = 0_{\mathbb{C}}`),
        " と仮定すると、",
        math(String.raw`\gamma_2(\theta) = (x,y)`),
        " と成分で書いて",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)
&= (x,y)
&&(\because\ \text{成分の置き方})\\
&= \bigl(x,-(-y)\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ -(-y) = y)\\
&= \overline{(x,-y)}
&&(\because\ \blkref{def_complex_conjugate})\\
&= \overline{\overline{(x,y)}}
&&(\because\ \blkref{def_complex_conjugate})\\
&= \overline{\overline{\gamma_2(\theta)}}
&&(\because\ \text{成分の置き方})\\
&= \overline{-\gamma_2(-\theta)}
&&(\because\ \text{上の}\ \overline{\gamma_2(\theta)} = -\gamma_2(-\theta))\\
&= \overline{-0_{\mathbb{C}}}
&&(\because\ \text{仮定}\ \gamma_2(-\theta) = 0_{\mathbb{C}})\\
&= \overline{(-1_{\mathbb{C}})\,0_{\mathbb{C}}}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \overline{0_{\mathbb{C}}}
&&(\because\ \blkref{complex_times_zero_is_zero})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を}\ r = 0\ \text{で})
\end{aligned}`),
      paragraph([
        "となり、",
        ref("gamma_2_theta_tilde_nonzero"),
        " に反する。よって ",
        math(String.raw`\gamma_2(-\theta) \neq 0_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        "(3) 以下 ",
        math(String.raw`r := |\gamma_2(\theta)|^2 \in \mathbb{R}_{>0}`),
        " と置く（",
        math(String.raw`r > 0`),
        " は (2) で示した）。まず ",
        math(String.raw`\phi_{\mathrm{polar}}((-r)_{\mathbb{C}})`),
        " を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\bigl((-r)_{\mathbb{C}}\bigr)
&= \phi_{\mathrm{polar}}\bigl((-r,0)\bigr)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= \left[\left(\sqrt{(-r)^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&(\because\ \blkref{def_phi_polar}\ \text{の}\ x = -r < 0,\ y = 0 \geq 0\ \text{の場合})\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan 0+\pi\right)\right]_{\sim}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \left[\left(r,\ \arctan 0+\pi\right)\right]_{\sim}
&&(\because\ r \geq 0\ \text{かつ}\ r^2 = r^2\ \text{なので、}\blkref{definition_of_sqrt_r_positive}\ \text{のただ一つの元は}\ r)\\
&= \left[\left(r,\ \pi\right)\right]_{\sim}
&&(\because\ \text{準備の}\ \arctan 0 = 0)
\end{aligned}`),
      paragraph(["主張 (3) の左辺から始める。"]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\gamma_2(\theta)\gamma_2(-\theta)\right)
&= \arg^{[0,2\pi)}\!\left((-r)_{\mathbb{C}}\right)
&&(\because\ (2))\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\bigl(\phi_{\mathrm{polar}}((-r)_{\mathbb{C}})\bigr)\right)
&&(\because\ \blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\bigl([(r,\pi)]_{\sim}\bigr)\right)
&&(\because\ \text{上の}\ \phi_{\mathrm{polar}}((-r)_{\mathbb{C}})\ \text{の値})\\
&= s_{[0,2\pi)}\!\left([\pi]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \blkref{first_and_second_projections}\ \text{の}\ r \neq 0\ \text{の場合})\\
&= \pi - 2\cdot 0\cdot\pi
&&(\because\ \blkref{section_of_angle_representation}\ \text{と準備の、角度}\ \pi\ \text{の整数は}\ 0)\\
&= \pi
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "(4) まず ",
        math(String.raw`-\gamma_2(\theta)\gamma_2(-\theta)`),
        " と ",
        math(String.raw`\phi_{\mathrm{polar}}(r_{\mathbb{C}})`),
        " を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
-\gamma_2(\theta)\gamma_2(-\theta)
&= (-1_{\mathbb{C}})\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= (-1_{\mathbb{C}})\,(-r)_{\mathbb{C}}
&&(\because\ (2))\\
&= \bigl((-1)(-r)\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= r_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\bigl(r_{\mathbb{C}}\bigr)
&= \phi_{\mathrm{polar}}\bigl((r,0)\bigr)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= \left[\left(\sqrt{r^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/r)\right)\right]_{\sim}
&&(\because\ \blkref{def_phi_polar}\ \text{の}\ x = r > 0\ \text{の場合})\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan 0\right)\right]_{\sim}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \left[\left(r,\ \arctan 0\right)\right]_{\sim}
&&(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{のただ一つの元は}\ r)\\
&= \left[\left(r,\ 0\right)\right]_{\sim}
&&(\because\ \text{準備の}\ \arctan 0 = 0)
\end{aligned}`),
      paragraph([
        "代表元 ",
        math(String.raw`(r,0)`),
        " の角度 ",
        math(String.raw`0`),
        " の整数は準備により ",
        math(String.raw`0`),
        " である。主張 (4) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{-\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{r_{\mathbb{C}}}
&&(\because\ \text{上の}\ -\gamma_2(\theta)\gamma_2(-\theta) = r_{\mathbb{C}})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \blkref{sqrt_expansion_via_polar}\ \text{を代表元}\ (r,0)\ \text{と整数}\ 0\ \text{で})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \left|\gamma_2(\theta)\right| \geq 0\ \text{かつ}\ \left|\gamma_2(\theta)\right|^2 = r\ \text{なので、}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ 0\right)\right]_{\sim}\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cos 0,\ \left|\gamma_2(\theta)\right|\sin 0\bigr)
&&(\because\ \blkref{def_phi_cartesian})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 1,\ \left|\gamma_2(\theta)\right|\sin 0\bigr)
&&(\because\ \blkref{cosine_zero})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 1,\ \left|\gamma_2(\theta)\right|\cdot 0\bigr)
&&(\because\ \blkref{sine_zero})\\
&= \bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&= \left|\gamma_2(\theta)\right|_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        "主張 (4) の右辺 ",
        math(String.raw`|\gamma_2(\theta)|`),
        " はこの実数の像として読み、",
        math(String.raw`|\gamma_2(\theta)| > 0`),
        " は (2) で示した。",
      ]),
      paragraph([
        "(5) 上の ",
        math(String.raw`\phi_{\mathrm{polar}}((-r)_{\mathbb{C}}) = [(r,\pi)]_{\sim}`),
        " の代表元 ",
        math(String.raw`(r,\pi)`),
        " の角度 ",
        math(String.raw`\pi`),
        " の整数は準備により ",
        math(String.raw`0`),
        " である。主張 (5) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{(-r)_{\mathbb{C}}}
&&(\because\ (2))\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\pi}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \blkref{sqrt_expansion_via_polar}\ \text{を代表元}\ (r,\pi)\ \text{と整数}\ 0\ \text{で})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{\pi}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \left|\gamma_2(\theta)\right| \geq 0\ \text{かつ}\ \left|\gamma_2(\theta)\right|^2 = r\ \text{なので、}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{\pi}{2}\right)\right]_{\sim}\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cos\tfrac{\pi}{2},\ \left|\gamma_2(\theta)\right|\sin\tfrac{\pi}{2}\bigr)
&&(\because\ \blkref{def_phi_cartesian})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 0,\ \left|\gamma_2(\theta)\right|\sin\tfrac{\pi}{2}\bigr)
&&(\because\ \text{準備の}\ \cos(\pi/2) = 0)\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 0,\ \left|\gamma_2(\theta)\right|\cdot 1\bigr)
&&(\because\ \text{準備の}\ \sin(\pi/2) = 1)\\
&= \bigl(0,\ \left|\gamma_2(\theta)\right|\bigr)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&= (0,1)\bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の積}\ (0\cdot|\gamma_2(\theta)| - 1\cdot 0,\ 0\cdot 0 + 1\cdot|\gamma_2(\theta)|))\\
&= i\bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= i\left|\gamma_2(\theta)\right|_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "(4)(5) は 008 章では独立の主張になっていないが、半整数運動量では γ_2 ≠ 0 が常に成り立つため、" +
          "根号の中身が正の実数（(4)）・負の実数（(5)）に確定する。これにより後続の固有値・固有ベクトルの計算から" +
          "複素平方根の分枝の議論（008 章 eigenvector_of_A_theta が condition_of_commutativity_of_sqrt_and_product を" +
          "経由して行っていた部分）を追い出せる。",
        "検算: sagemath/check/relation_of_gamma_2_theta_tilde/（厳密計算。浮動小数点の旧検算 sagemath/check/048_claim_A_theta_tilde/check_02 も残っている）。",
        "2026-08-19 の式変形統一で、補助的な共役計算の末尾に複素数の四則という行末根拠を補い、散文で行っていた両辺の符号反転を主張 (1) の左辺から始まる一段の鎖へ移した。(5) の終端にも三角関数の特殊値と複素数の四則を行末根拠として明記した。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: SageMath の検算（sagemath/check/relation_of_gamma_2_theta_tilde/）を付けるときに証明を直した。γ_2(−θ) の表示を def_gamma1_gamma2_of_theta の証明から借りず、euler_formula_cos_sin から cos(−θ)・sin(−θ) を求める鎖で作った。複素共役の行の根拠を complex_conjugate_of_product・complex_conjugate_of_difference・complex_conjugate_of_sum・complex_conjugate_of_real_inclusion に、ī = −i と conj(exp(iθ)) = exp(−iθ) を鎖に、z conj(z) = |z|^2 の根拠を abs_basic_properties（この性質を述べていない）から complex_conjugate_times_self に直した。(2) の狭義の負と γ_2(−θ) ≠ 0 を鎖に、(3)(4)(5) の偏角・平方根を def_phi_polar・def_abs_arg・sqrt_expansion_via_polar・def_phi_cartesian から一行ずつの鎖にした。主張の中身は不変。",
      ],
    },
  },
  {
    id: "Athetatilde_004_claim_eigenvector",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 6 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の固有値と固有ベクトル}` },
    labels: ["eigenvector_of_A_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の固有値（",
        ref("def_eigenvalue"),
        "）は",
      ]),
      displayMath(
        String.raw`\lambda_{\pm,\mu}
:= \gamma_1(\tilde\theta_\mu) \pm \sqrt{-\gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)}
 = \gamma_1(\tilde\theta_\mu) \pm \left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}`,
      ),
      paragraph([
        "の 2 つであり（",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) により根号は正の実数、したがって ",
        math(String.raw`\lambda_{+,\mu} \neq \lambda_{-,\mu}`),
        "）、",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について",
      ]),
      displayMath(
        String.raw`v_{\pm,\mu}
:= c\begin{pmatrix} \pm i\,\sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)} \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}
= c\begin{pmatrix} \mp\left|\gamma_2(\tilde\theta_\mu)\right| \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}`,
      ),
      paragraph([
        "は ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " に属する固有ベクトル（",
        ref("def_eigenvector"),
        "）である。",
        ref("gamma_2_theta_tilde_nonzero"),
        " により ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " なので、場合分けは要らない。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\theta := \tilde\theta_\mu`),
        "、",
        math(String.raw`g_1 := \gamma_1(\theta) \in \mathbb{R}`),
        "、",
        math(String.raw`a := \gamma_2(\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`b := \gamma_2(-\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記する（",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " なので ",
        math(String.raw`r > 0`),
        "）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b = -\bar a`),
        "、",
        math(String.raw`ab = -r^2`),
        "、",
        math(String.raw`\sqrt{-ab} = r`),
        "、",
        math(String.raw`\sqrt{ab} = ir`),
        " である。",
      ]),
      paragraph([
        "Step 1（固有値がこの 2 つに限ること）。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`A(\theta) = \begin{pmatrix} g_1 & a \\ -b & g_1\end{pmatrix}`),
        " である。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）とおき、",
        math(String.raw`\lambda \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\lambda \text{ は } A(\theta) \text{ の固有値} \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v = \lambda v
   &&\bigl(\because \blkref{def_eigenvalue}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - \lambda v = 0
   &&\bigl(\because \blkref{matrix_difference_zero_iff_equal}\text{ を } 2 \text{ 行 } 1 \text{ 列の行列 } A(\theta)v,\ \lambda v \text{ に適用}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - \lambda (Iv) = 0
   &&\bigl(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\text{ を } 2 \text{ 行 } 1 \text{ 列の行列 } v \text{ に適用}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - (\lambda I)v = 0
   &&\bigl(\because \blkref{scalar_multiple_factors_out_of_left_factor}\text{ を } a := \lambda,\ A := I,\ B := v \text{ に適用し、右辺から左辺へ}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ \left(A(\theta) - \lambda I\right)v = 0
   &&\bigl(\because \blkref{matrix_difference_mul_vector}\bigr) \\
&\iff \det\left(A(\theta) - \lambda I\right) = 0
   &&\bigl(\because \blkref{nonzero_kernel_iff_det_zero_two_by_two}\text{ を } B := A(\theta) - \lambda I \text{ に適用}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "準備として、因数分解の恒等式を確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\lambda - (g_1+r))(\lambda - (g_1-r))
&= \lambda^2 - (g_1-r)\lambda - (g_1+r)\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2-g_1r+rg_1-r^2\right)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \mathbb{C}\text{ の乗法の可換則と加法逆元})
\end{aligned}`,
      ),
      paragraph(["そこで"]),
      displayMath(
        String.raw`\begin{aligned}
\det\left(A(\theta) - \lambda I\right)
&= \det\begin{pmatrix}
     A(\theta)_{11} - (\lambda I)_{11} & A(\theta)_{12} - (\lambda I)_{12} \\
     A(\theta)_{21} - (\lambda I)_{21} & A(\theta)_{22} - (\lambda I)_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_matrix_difference}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda I_{11} & A(\theta)_{12} - \lambda I_{12} \\
     A(\theta)_{21} - \lambda I_{21} & A(\theta)_{22} - \lambda I_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_matrix_scalar_multiple}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda \delta_{11} & A(\theta)_{12} - \lambda \delta_{12} \\
     A(\theta)_{21} - \lambda \delta_{21} & A(\theta)_{22} - \lambda \delta_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_identity_matrix}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda \cdot 1 & A(\theta)_{12} - \lambda \cdot 0 \\
     A(\theta)_{21} - \lambda \cdot 0 & A(\theta)_{22} - \lambda \cdot 1
   \end{pmatrix}
   \quad (\because \blkref{def_kronecker_delta}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} - \lambda \cdot 0 \\
     A(\theta)_{21} - \lambda \cdot 0 & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because x \cdot 1 = x\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} - 0 \\
     A(\theta)_{21} - 0 & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because x \cdot 0 = 0\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} \\
     A(\theta)_{21} & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because y - 0 = y\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix} g_1-\lambda & a \\ -b & g_1-\lambda\end{pmatrix}
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}) \\
&= (g_1-\lambda)(g_1-\lambda) - a\cdot(-b)
   \quad (\because \blkref{def_det_two_by_two}) \\
&= (g_1-\lambda)(g_1-\lambda) + ab
   \quad (\because \mathbb{C} \text{ の四則}\ (-a\cdot(-b) = ab)) \\
&= g_1^2-g_1\lambda-\lambda g_1+\lambda^2+ab
   \quad (\because \text{分配則}) \\
&= g_1^2-g_1\lambda-g_1\lambda+\lambda^2+ab
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= g_1^2-2g_1\lambda+\lambda^2+ab
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 + ab\right)
   \quad (\because \mathbb{C}\text{ の加法の交換則と結合則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (ab = -r^2)) \\
&= (\lambda - (g_1+r))(\lambda - (g_1-r))
   \quad (\because \text{準備の因数分解の恒等式})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから、この積が ",
        math(String.raw`0`),
        " になるのは ",
        math(String.raw`\lambda = g_1 \pm r`),
        " のときに限る。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) の ",
        math(String.raw`\sqrt{-ab} = r`),
        " より、これは statement の ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " に一致する。",
        math(String.raw`r > 0`),
        " なので ",
        math(String.raw`\lambda_{+,\mu} - \lambda_{-,\mu} = 2r \neq 0`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`v_{\pm,\mu}`),
        " が固有ベクトルであること）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (5) より ",
        math(String.raw`\pm i\sqrt{ab} = \pm i\cdot ir = \mp r`),
        " なので、statement の 2 つの表示は一致する。",
        math(String.raw`c = 1`),
        " として ",
        math(String.raw`v_\pm := (\mp r,\ b)^{\mathsf{T}}`),
        " を代入すると、",
        math(String.raw`b = -\bar a`),
        " と ",
        math(String.raw`a\bar a = r^2`),
        " より第 1 成分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_1
&= g_1(\mp r) + a\,b
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ と行列とベクトルの積の定義}) \\
&= \mp g_1 r + a\left(-\bar a\right)
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (b = -\bar a)) \\
&= \mp g_1 r - r^2
   \quad (\because \blkref{abs_basic_properties}\ (a\bar a = |a|^2 = r^2)) \\
&= \left(g_1 \pm r\right)\left(\mp r\right)
   \quad (\because \text{分配則}\ (\left(g_1 \pm r\right)\left(\mp r\right) = \mp g_1 r - r^2)) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_1
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_1 = \mp r)
\end{aligned}`,
      ),
      paragraph([ref("def_gamma1_gamma2_of_theta"), "、", ref("relation_of_gamma_2_theta_tilde"), "、", ref("abs_basic_properties"), " が各行の根拠である。"]),
      paragraph(["第 2 成分は"]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_2
&= (-b)(\mp r) + g_1 b
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ と行列とベクトルの積の定義}) \\
&= b(\pm r) + g_1 b
   \quad (\because \mathbb{C}\text{ の四則}\ ((-b)(\mp r) = b(\pm r))) \\
&= (\pm r)\,b + g_1 b
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= \left(\pm r + g_1\right)b
   \quad (\because \text{分配則で } b \text{ を括り出す}) \\
&= \left(g_1 \pm r\right)b
   \quad (\because \mathbb{C}\text{ の加法の交換則（下の符号では } g_1 + (-r) = g_1 - r \text{ と書く）}) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_2
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_2 = b)
\end{aligned}`,
      ),
      paragraph(["第 1 行の根拠は ", ref("def_gamma1_gamma2_of_theta"), " である。"]),
      paragraph([
        "よって ",
        math(String.raw`A(\theta)v_\pm = \lambda_{\pm,\mu}v_\pm`),
        "。",
        math(String.raw`b \neq 0`),
        "（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）より ",
        math(String.raw`v_\pm \neq 0`),
        " であり、これは固有ベクトルである。",
        math(String.raw`c \in \mathbb{C}^\times`),
        " 倍しても固有ベクトルであることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta)(cv)
&= c\,A(\theta)v
   \quad (\because \text{行列とベクトルの積の各成分の分配則（スカラー倍は積の外へ出る）}) \\
&= c(\lambda v)
   \quad (\because \text{上で示した } A(\theta)v = \lambda v \text{ の代入}) \\
&= \lambda(cv)
   \quad (\because \text{複素数の積の可換性と、ベクトルのスカラー倍の結合})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`v \neq 0`),
        " なので ",
        math(String.raw`v_k \neq 0`),
        " となる成分 ",
        math(String.raw`k \in \{1, 2\}`),
        " があり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(cv)_k
&= c\,v_k
   \quad (\because \text{ベクトルのスカラー倍は成分ごとの積}) \\
&\neq 0
   \quad (\because c \neq 0,\ v_k \neq 0 \text{ と、}\mathbb{C}\text{ は体ゆえ零因子を持たないこと（}\blkref{complex_numbers_form_a_field}\text{）})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`cv \neq 0`),
        "。よって ",
        math(String.raw`cv`),
        " も ",
        math(String.raw`\lambda`),
        " に属する固有ベクトル（",
        ref("def_eigenvector"),
        "）である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の eigenvector_of_A_theta は γ_2 = 0 の場合分けを持ち、γ_2 ≠ 0 の場合も複素平方根の分枝の扱い" +
          "（condition_of_commutativity_of_sqrt_and_product, inverse_of_sqrt_cc）を経由して固有ベクトルを導いていた。" +
          "半整数運動量では relation_of_gamma_2_theta_tilde (4)(5) で根号が |γ_2| と i|γ_2| に確定するので、" +
          "固有ベクトルは代入して確かめるだけで済む。得られる形は 008 章と同一である。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（特性方程式・固有ベクトル・Sage の固有値集合との一致、残差 ≤ 2e-12）。",
        "2026-08-19 の式変形統一で、Step 1 の「右辺を展開すれば左辺に一致する」と散文に畳まれていた因数分解を、" +
          "準備の恒等式と行列式の一続きの鎖へ開き、固有ベクトル成分の二本の鎖の根拠なしの行に行末根拠を補った。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-01: Step 1 が「固有値」を定義せずに「固有値 ⟺ det(A(θ) − λI) = 0」を証明なしに使っていたので、" +
          "def_eigenvalue・def_eigenvector・def_det_two_by_two を数学的道具立てに置き、同値を nonzero_kernel_iff_det_zero_two_by_two（2×2 の成分計算）から引く同値の鎖にした。" +
          "Lean の eigenvalue_AMat_iff と同じ手順である。",
        "2026-11-01: Step 3（固有空間が 1 次元で、固有ベクトルは v_{±,μ} の ℂ^× 倍に限ること）と statement の「限る」の側を、" +
          "参照用ノート claims_unused_by_chapter_goals_not_adopted へ退避した。後段（diagonalization_check_P_D ほか）が使うのは " +
          "λ_{±,μ} の値と A(θ̃_μ)v_{±,μ} = λ_{±,μ}v_{±,μ} だけで、Step 3 は本文のどこからも使われず、" +
          "「階数」「固有空間」「次元」を本文で定義しないまま使っていたため。",
        "2026-11-01: c ∈ ℂ^× 倍が固有ベクトルであることのうち cv ≠ 0 の段が無かったので足した（Lean の isEigenvector_smul_eigen_pos/neg の smul_ne_zero と同じ手順）。",
        "2026-11-01: Step 2 の第 2 成分は b = -ā を代入して ā を括り出し、最後に (v_±)_2 = b = -ā で b へ戻す往復をしていた。" +
          "b のまま括り出す鎖にし、b = -ā を使わない形にした（Lean の必要十分版 skew2_mulVec_pos/neg の第 2 成分が仮定なしで閉じることの反映）。",
      ],
    },
  },
  {
    id: "Athetatilde_005_claim_diagonalization",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 7 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の対角化 } (\check{P}_\mu,\, \check{D}_\mu)` },
    labels: ["diagonalization_check_P_D"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
        ref("eigenvector_of_A_theta_tilde"),
        " の任意定数を ",
        math(String.raw`c = \dfrac{1}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}`),
        " と選んで",
      ]),
      displayMath(
        String.raw`\check{P}_\mu
:= \begin{pmatrix}
\dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}
& \dfrac{+\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix},
\qquad
\check{D}_\mu := \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu}\end{pmatrix}`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\det\check{P}_\mu
= \frac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2M_{\mathrm{col}}\,\gamma_2(-\tilde\theta_\mu)} \neq 0_{\mathbb{C}},
\qquad
A(\tilde\theta_\mu) = \check{P}_\mu\,\check{D}_\mu\,\check{P}_\mu^{-1}`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("eigenvector_of_A_theta_tilde"),
        " の記号 ",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a|`),
        " を使う。",
      ]),
      paragraph([
        "Step 1（各成分が定まること）。",
        ref("gamma_2_theta_tilde_nonzero"),
        " と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`a \neq 0`),
        " かつ ",
        math(String.raw`b \neq 0`),
        "。また ",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " より ",
        math(String.raw`\sqrt{M_{\mathrm{col}}} > 0`),
        "（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。よって分母 ",
        math(String.raw`2\sqrt{M_{\mathrm{col}}}\,b \neq 0`),
        " であり、",
        math(String.raw`c := \dfrac{1}{2\sqrt{M_{\mathrm{col}}}\,b} \in \mathbb{C}^\times`),
        " が定まって ",
        math(String.raw`\check{P}_\mu`),
        " の 4 成分はすべて定まる。",
      ]),
      paragraph([
        "Step 2（2 つの列が固有ベクトルであること）。",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`v_{\pm,\mu} = c(\mp r,\ b)^{\mathsf{T}}`),
        " に上の ",
        math(String.raw`c`),
        " を代入すると、第 2 成分は次の鎖で定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
cb
&= \frac{1}{2\sqrt{M_{\mathrm{col}}}\,b}\,b
   \quad (\because c\text{ の定義}) \\
&= \frac{1}{2\sqrt{M_{\mathrm{col}}}}
   \quad (\because b\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`v_{+,\mu}, v_{-,\mu}`),
        " はそれぞれ ",
        math(String.raw`\check{P}_\mu`),
        " の第 1 列・第 2 列に一致する。行列の積を列ごとに見れば",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)\,\check{P}_\mu
&= \left(A(\tilde\theta_\mu)v_{+,\mu}\ \ A(\tilde\theta_\mu)v_{-,\mu}\right)
   \quad (\because \text{行列の積を列ごとに見た}) \\
&= \left(\lambda_{+,\mu}v_{+,\mu}\ \ \lambda_{-,\mu}v_{-,\mu}\right)
   \quad (\because \blkref{eigenvector_of_A_theta_tilde}\text{ を 2 列へ同時適用}) \\
&= \check{P}_\mu\,\check{D}_\mu
   \quad (\because \check{D}_\mu = \mathrm{diag}(\lambda_{+,\mu}, \lambda_{-,\mu}) \text{ の右乗が列ごとのスカラー倍})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`\det\check{P}_\mu`),
        "）。",
        ref("def_det_two_by_two"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det\check{P}_\mu
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,b}\cdot\frac{1}{2\sqrt{M_{\mathrm{col}}}}
 - \frac{+r}{2\sqrt{M_{\mathrm{col}}}\,b}\cdot\frac{1}{2\sqrt{M_{\mathrm{col}}}}
   \quad (\because \blkref{def_det_two_by_two}) \\
&= \frac{-r}{4M_{\mathrm{col}}\,b} - \frac{+r}{4M_{\mathrm{col}}\,b}
   \quad \left(\because \left(2\sqrt{M_{\mathrm{col}}}\right)^2 = 4M_{\mathrm{col}}\right) \\
&= \frac{-r}{4M_{\mathrm{col}}\,b} + \frac{-r}{4M_{\mathrm{col}}\,b}
   \quad (\because -\tfrac{+r}{4M_{\mathrm{col}}\,b}=\tfrac{-r}{4M_{\mathrm{col}}\,b}\text{。}\mathbb{C}\text{ の四則}) \\
&= 2\cdot\frac{-r}{4M_{\mathrm{col}}\,b}
   \quad (\because \text{同類項の統合}) \\
&= \frac{-r}{2M_{\mathrm{col}}\,b}
   \quad (\because 2M_{\mathrm{col}}\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r > 0`),
        "、",
        math(String.raw`2M_{\mathrm{col}} \neq 0`),
        "、",
        math(String.raw`b \neq 0`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " が零因子を持たないこと（",
        ref("complex_numbers_form_a_field"),
        "）から ",
        math(String.raw`\det\check{P}_\mu \neq 0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "Step 4（対角化）。",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " より ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在するので、Step 2 の両辺に右から掛けて ",
        "次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)
&= A(\tilde\theta_\mu)\left(\check{P}_\mu\check{P}_\mu^{-1}\right)
   \quad (\because \check{P}_\mu\check{P}_\mu^{-1}=I\text{ と積の単位元}) \\
&= \left(A(\tilde\theta_\mu)\check{P}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則}) \\
&= \left(\check{P}_\mu\check{D}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{Step 2}) \\
&= \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "正規化 c = 1/(2√M γ_2(−θ~_μ)) は 008 章の diagonalization_P_D と同じに揃えた（後段の半整数運動量フェルミオンで" +
          "同じ規格化を使うため）。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ)γ_2(−θ))/(2√M γ_2(−θ)) は、" +
          "relation_of_gamma_2_theta_tilde (5) により半整数運動量では −|γ_2|/(2√M γ_2(−θ~)) に等しい。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（det の明示式との一致、|det| ≥ 6.25e-2、" +
          "A − P̌ Ď P̌^{-1} の残差 ≤ 3e-14）。",
        "2026-08-19 の式変形統一で、固有ベクトルの第 2 成分の約分、行列式の同類項の統合、対角化の右乗を、" +
          "それぞれ主張の左辺から始まる一続きの鎖と行末根拠へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "Athetatilde_006_claim_det_A",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 8 },
    title: { tex: String.raw`\det A(\tilde\theta_\mu) = 1` },
    labels: ["det_A_theta_tilde"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\det A(\tilde\theta_\mu) = 1,
\qquad
\gamma_1(\tilde\theta_\mu)^2 + \gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu) = 1,
\qquad
\lambda_{+,\mu}\,\lambda_{-,\mu} = 1`,
      ),
      paragraph([
        "が成り立つ（第 1・第 2 の等式は ",
        math(String.raw`\mathbb{C}`),
        " の等式で、実数 ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)`),
        " と ",
        math(String.raw`1`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像として読む。",
        math(String.raw`\lambda_{\pm,\mu} \in \mathbb{R}`),
        "（",
        ref("eigenvector_of_A_theta_tilde"),
        "）なので第 3 の等式は ",
        math(String.raw`\mathbb{R}`),
        " の等式である）。とくに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) と合わせて",
      ]),
      displayMath(
        String.raw`\gamma_1(\tilde\theta_\mu)^2 = 1 + \left|\gamma_2(\tilde\theta_\mu)\right|^2`,
      ),
      paragraph(["が成り立つ（", math(String.raw`\mathbb{R}`), " の等式）。"]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta := \tilde\theta_\mu`),
        " と略記する。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\theta \in \mathbb{R}`),
        " である。",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記、",
        math(String.raw`u := \cos\theta \in \mathbb{R}`),
        "・",
        math(String.raw`v := \sin\theta \in \mathbb{R}`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値（全実数上への拡張は未整備）、",
        math(String.raw`a_0 := c_1u - s_1c_2 \in \mathbb{R}`),
        "、",
        math(String.raw`r := \left|\gamma_2(\theta)\right| \in \mathbb{R}`),
        "（",
        ref("def_abs_arg"),
        "）とおく。",
        math(String.raw`i := (0_{\mathbb{R}}, 1_{\mathbb{R}})`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " の前置きの虚数単位、",
        math(String.raw`e_+ := \exp(i\theta) \in \mathbb{C}`),
        "・",
        math(String.raw`e_- := \exp(-i\theta) \in \mathbb{C}`),
        " とする。実数が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは、",
        ref("def_gamma1_gamma2_of_theta"),
        " の書き方に従い ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`x_{\mathbb{C}}`),
        " として読み、像の記号を省く。",
        math(String.raw`x, y \in \mathbb{R}`),
        " について ",
        math(String.raw`x_{\mathbb{C}}y_{\mathbb{C}} = (xy)_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_product"),
        "）、",
        math(String.raw`x_{\mathbb{C}} + y_{\mathbb{C}} = (x+y)_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_finite_sum"),
        " を ",
        math(String.raw`m = 2`),
        " で）であり、差は ",
        ref("def_complex_difference"),
        " により ",
        math(String.raw`-1_{\mathbb{C}}`),
        " 倍（",
        ref("multiply_by_minus_one"),
        "。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`(-1)_{\mathbb{C}}`),
        "）の和なので、実数の和・差・積の像は像の和・差・積である。",
        math(String.raw`\mathbb{C}`),
        " の和と積の結合律・可換律・分配律・単位元・零元・加法逆元・乗法の逆元は ",
        ref("complex_numbers_form_a_field"),
        " による。",
        math(String.raw`w \neq 0_{\mathbb{C}}`),
        " について ",
        math(String.raw`w^{-1}`),
        " はその乗法の逆元、商は ",
        math(String.raw`z/w := z\,w^{-1}`),
        " とする。",
        math(String.raw`2_{\mathbb{C}} = (2,0)`),
        "、",
        math(String.raw`i = (0,1)`),
        "、",
        math(String.raw`2_{\mathbb{C}}\,i = (2\cdot 0 - 0\cdot 1,\ 2\cdot 1 + 0\cdot 0) = (0,2)`),
        "（",
        ref("definition_of_cc"),
        " の積）は、いずれも成分の一つが ",
        math(String.raw`0`),
        " でないので ",
        math(String.raw`0_{\mathbb{C}} = (0,0)`),
        " と異なり、逆元を持つ。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`-(-z) = z`),
        "（",
        math(String.raw`z \in \mathbb{C}`),
        "）、",
        math(String.raw`ii = -1_{\mathbb{C}}`),
        "、",
        math(String.raw`e_+e_- = 1_{\mathbb{C}}`),
        "、",
        math(String.raw`x, y \in \mathbb{C}`),
        " についての ",
        math(String.raw`(x - iy)(x + iy) = x^2 + y^2`),
        " と ",
        math(String.raw`(x - y)^2 = x^2 - 2_{\mathbb{C}}xy + y^2`),
        "、",
        math(String.raw`u + iv = e_+`),
        "、",
        math(String.raw`u^2 + v^2 = 1_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
-(-z)
&= (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})z\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)z
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \bigl((-1)(-1)\bigr)_{\mathbb{C}}\,z
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= 1_{\mathbb{C}}\,z
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= z
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
ii
&= (0,1)(0,1)
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= (0\cdot 0 - 1\cdot 1,\ 0\cdot 1 + 1\cdot 0)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (-1, 0)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= -1_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_+e_-
&= \exp(i\theta)\exp(-i\theta)
&&(\because\ e_\pm\ \text{の定義})\\
&= \exp\bigl(i\theta + (-i\theta)\bigr)
&&(\because\ \blkref{scalar_exp_product}\ \text{を}\ K = \mathbb{C}\ \text{で})\\
&= \exp(0_{\mathbb{C}})
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{scalar_exp_zero}\ \text{を}\ K = \mathbb{C}\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(x - iy)(x + iy)
&= \bigl(x + (-(iy))\bigr)(x + iy)
&&(\because\ \blkref{def_complex_difference})\\
&= \bigl(x + (-1_{\mathbb{C}})(iy)\bigr)(x + iy)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= xx + x(iy) + \bigl((-1_{\mathbb{C}})(iy)\bigr)x + \bigl((-1_{\mathbb{C}})(iy)\bigr)(iy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= xx + (iy)x + (-1_{\mathbb{C}})\bigl((iy)x\bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + \Bigl((iy)x + (-1_{\mathbb{C}})\bigl((iy)x\bigr)\Bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= xx + \Bigl((iy)x + \bigl(-((iy)x)\bigr)\Bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= xx + 0_{\mathbb{C}} + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= xx + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= xx + (-1_{\mathbb{C}})\bigl((ii)(yy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})(yy)\bigr)
&&(\because\ \text{上の}\ ii = -1_{\mathbb{C}})\\
&= xx + \bigl(-(-(yy))\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= xx + yy
&&(\because\ \text{上の}\ -(-z) = z)\\
&= x^2 + y^2
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = (1_{\mathbb{C}}z)z = zz\ \text{を 2 箇所へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(x - y)^2
&= (x - y)(x - y)
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz)\\
&= \bigl(x + (-y)\bigr)\bigl(x + (-y)\bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ})\\
&= \bigl(x + (-1_{\mathbb{C}})y\bigr)\bigl(x + (-1_{\mathbb{C}})y\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= xx + x\bigl((-1_{\mathbb{C}})y\bigr) + \bigl((-1_{\mathbb{C}})y\bigr)x + \bigl((-1_{\mathbb{C}})y\bigr)\bigl((-1_{\mathbb{C}})y\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= xx + (-1_{\mathbb{C}})(xy) + (-1_{\mathbb{C}})(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + \bigl((-1_{\mathbb{C}}) + (-1_{\mathbb{C}})\bigr)(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= xx + \bigl((-1) + (-1)\bigr)_{\mathbb{C}}(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&= xx + \bigl((-1) + (-1)\bigr)_{\mathbb{C}}(xy) + \bigl((-1)(-1)\bigr)_{\mathbb{C}}(yy)
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= xx + \bigl((-1)\cdot 2\bigr)_{\mathbb{C}}(xy) + 1_{\mathbb{C}}(yy)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&= xx + \bigl((-1_{\mathbb{C}})\,2_{\mathbb{C}}\bigr)(xy) + 1_{\mathbb{C}}(yy)
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= xx + (-1_{\mathbb{C}})\bigl(2_{\mathbb{C}}(xy)\bigr) + 1_{\mathbb{C}}(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= xx + (-1_{\mathbb{C}})\bigl(2_{\mathbb{C}}(xy)\bigr) + yy
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= xx + \bigl(-(2_{\mathbb{C}}xy)\bigr) + yy
&&(\because\ \blkref{multiply_by_minus_one})\\
&= xx - 2_{\mathbb{C}}xy + yy
&&(\because\ \blkref{def_complex_difference})\\
&= x^2 - 2_{\mathbb{C}}xy + y^2
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz\ \text{を 2 箇所へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
u + iv
&= \frac{e_+ + e_-}{2} + i\,\frac{e_+ - e_-}{2i}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{を 2 箇所へ})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + i\bigl((e_+ - e_-)(2_{\mathbb{C}}i)^{-1}\bigr)
&&(\because\ \text{準備の商}\ z/w := zw^{-1}\ \text{を 2 箇所へ})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(i\,(2_{\mathbb{C}}i)^{-1}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(i\,(2_{\mathbb{C}}^{-1}i^{-1})\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元の一意性より}\ (2_{\mathbb{C}}i)^{-1} = 2_{\mathbb{C}}^{-1}i^{-1})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(2_{\mathbb{C}}^{-1}(i\,i^{-1})\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(2_{\mathbb{C}}^{-1}1_{\mathbb{C}}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \bigl((e_+ + e_-) + (e_+ - e_-)\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= \Bigl((e_+ + e_-) + \bigl(e_+ + (-e_-)\bigr)\Bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{def_complex_difference})\\
&= \Bigl(e_+ + e_+ + \bigl(e_- + (-e_-)\bigr)\Bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= \bigl(e_+ + e_+ + 0_{\mathbb{C}}\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \bigl(e_+ + e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= \bigl(1_{\mathbb{C}}e_+ + 1_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \bigl((1_{\mathbb{C}} + 1_{\mathbb{C}})e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= \bigl((1 + 1)_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&= \bigl(2_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \mathbb{R}\ \text{の四則}\ 1 + 1 = 2)\\
&= e_+\bigl(2_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= e_+\,1_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元})\\
&= e_+
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
u^2 + v^2
&= (u - iv)(u + iv)
&&(\because\ \text{上の}\ (x - iy)(x + iy) = x^2 + y^2\ \text{を}\ x = u,\ y = v\ \text{で})\\
&= e_-\,(u + iv)
&&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin})\\
&= e_-\,e_+
&&(\because\ \text{上の}\ u + iv = e_+)\\
&= e_+e_-
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{上の}\ e_+e_- = 1_{\mathbb{C}})
\end{aligned}`),
      paragraph([
        "第二に、",
        math(String.raw`\gamma_2(\theta)`),
        "・",
        math(String.raw`\gamma_2(-\theta)`),
        " とその積を ",
        math(String.raw`a_0, v`),
        " で書く。",
        math(String.raw`\gamma_2(-\theta)`),
        " は ",
        ref("def_gamma1_gamma2_of_theta"),
        " が述べる ",
        math(String.raw`A(\theta)`),
        " の ",
        math(String.raw`(2,1)`),
        " 成分 ",
        math(String.raw`-\gamma_2(-\theta)`),
        " と ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分を比べて得る（",
        ref("def_A_theta"),
        " の先頭の ",
        math(String.raw`-`),
        " は ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-1`),
        " 倍と読む）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)
&= i\,e_+\,s_2^*\bigl(c_1u - iv - s_1c_2\bigr)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= i\,e_+\,s_2^*\bigl((c_1u - s_1c_2) - iv\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= i\,e_+\,s_2^*\bigl(a_0 - iv\bigr)
&&(\because\ a_0\ \text{の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= -\bigl(-\gamma_2(-\theta)\bigr)
&&(\because\ \text{上の}\ -(-z) = z)\\
&= -A(\theta)_{2,1}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{の}\ (2,1)\ \text{成分})\\
&= -\Bigl(-\bigl(i\,e_-\,s_2^*(c_1u + iv - s_1c_2)\bigr)\Bigr)
&&(\because\ \blkref{def_A_theta}\ \text{の}\ (2,1)\ \text{成分})\\
&= i\,e_-\,s_2^*\bigl(c_1u + iv - s_1c_2\bigr)
&&(\because\ \text{上の}\ -(-z) = z)\\
&= i\,e_-\,s_2^*\bigl((c_1u - s_1c_2) + iv\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= i\,e_-\,s_2^*\bigl(a_0 + iv\bigr)
&&(\because\ a_0\ \text{の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \bigl(i\,e_+\,s_2^*(a_0 - iv)\bigr)\bigl(i\,e_-\,s_2^*(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ \gamma_2(\theta)\ \text{と}\ \gamma_2(-\theta)\ \text{の表示})\\
&= (ii)(e_+e_-)(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (-1_{\mathbb{C}})(e_+e_-)(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ ii = -1_{\mathbb{C}})\\
&= (-1_{\mathbb{C}})\,1_{\mathbb{C}}\,(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ e_+e_- = 1_{\mathbb{C}})\\
&= (-1_{\mathbb{C}})(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= (-1_{\mathbb{C}})(s_2^*s_2^*)\bigl(a_0^2 + v^2\bigr)
&&(\because\ \text{上の}\ (x - iy)(x + iy) = x^2 + y^2\ \text{を}\ x = a_0,\ y = v\ \text{で})\\
&= (-1_{\mathbb{C}})\Bigl((s_2^*s_2^*)\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz)\\
&= -\Bigl((s_2^*)^2\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one})
\end{aligned}`),
      paragraph([
        "第三に、",
        ref("cosh_sinh_basic_properties"),
        " (2) と ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " から ",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^*`),
        " の間の ",
        math(String.raw`\mathbb{R}`),
        " の関係を三つ作る（",
        math(String.raw`2K_1, 2K_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の結合定数と第二の双対結合定数の 2 倍である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
c_1^2 - s_1^2
&= (\cosh 2K_1)^2 - (\sinh 2K_1)^2
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= 1
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2)\ \text{を}\ x = 2K_1\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(c_2^*)^2 - (s_2^*)^2
&= (\cosh 2K_2^*)^2 - (\sinh 2K_2^*)^2
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= 1
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2)\ \text{を}\ x = 2K_2^*\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_2s_2^*
&= s_2^*c_2
&&(\because\ \mathbb{R}\ \text{の積の可換律})\\
&= c_2^*
&&(\because\ \blkref{duality_c2_star_eq_s2_star_c2})
\end{aligned}`),
      paragraph([
        "第 2 の等式は、主張の左辺から次のとおりである（",
        math(String.raw`\mathbb{C}`),
        " の等式）。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta) \\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 + \Bigl(-\bigl((s_2^*)^2(a_0^2 + v^2)\bigr)\Bigr)
&&(\because\ \text{上の}\ \gamma_2(\theta)\gamma_2(-\theta)\ \text{の鎖})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + v^2\bigr)
&&(\because\ \blkref{def_complex_difference})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + 1 - u^2\bigr)
&&(\because\ \text{上の}\ u^2 + v^2 = 1_{\mathbb{C}}\ \text{を移項した}\ v^2 = 1 - u^2)\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl((c_1u - s_1c_2)^2 + 1 - u^2\bigr)
&&(\because\ a_0\ \text{の定義})\\
&\quad= (c_1c_2^*)^2 - 2(c_1c_2^*)(s_1s_2^*u) + (s_1s_2^*u)^2 \\
&\qquad\quad - (s_2^*)^2\bigl((c_1u)^2 - 2(c_1u)(s_1c_2) + (s_1c_2)^2 + 1 - u^2\bigr)
&&(\because\ \text{上の}\ (x - y)^2 = x^2 - 2xy + y^2\ \text{を 2 箇所へ})\\
&\quad= (c_1c_2^*)(c_1c_2^*) - 2(c_1c_2^*)(s_1s_2^*u) + (s_1s_2^*u)(s_1s_2^*u) \\
&\qquad\quad - (s_2^*s_2^*)\bigl((c_1u)(c_1u) - 2(c_1u)(s_1c_2) + (s_1c_2)(s_1c_2) + 1 - uu\bigr)
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz)\\
&\quad= (c_1c_1)(c_2^*c_2^*) - 2c_1c_2^*s_1s_2^*u + (s_1s_1)(s_2^*s_2^*)(uu) \\
&\qquad\quad - (s_2^*s_2^*)\bigl((c_1c_1)(uu) - 2c_1s_1c_2u + (s_1s_1)(c_2c_2) + 1 - uu\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - (s_2^*)^2\bigl(c_1^2u^2 - 2c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2\bigr)
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ zz = z^2)\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + \Bigl(-\bigl((s_2^*)^2(c_1^2u^2 - 2c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2)\bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + \Bigl(-\Bigl((s_2^*)^2\bigl(c_1^2u^2 + (-(2c_1s_1c_2u)) + s_1^2c_2^2 + 1 + (-u^2)\bigr)\Bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl(c_1^2u^2 + (-1_{\mathbb{C}})(2c_1s_1c_2u) + s_1^2c_2^2 + 1 + (-1_{\mathbb{C}})u^2\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 3 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl((s_2^*)^2c_1^2u^2\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2(-1_{\mathbb{C}})(2c_1s_1c_2u)\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl((s_2^*)^2s_1^2c_2^2\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2\cdot 1\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2(-1_{\mathbb{C}})u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(2c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2\cdot 1\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(2c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1)(-1)\bigr)_{\mathbb{C}}\bigl(2c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1)(-1)\bigr)_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl(2c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 2c_1s_1c_2(s_2^*)^2u \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + \bigl(-(c_1^2(s_2^*)^2u^2)\bigr) + 2c_1s_1c_2(s_2^*)^2u + \bigl(-(s_1^2c_2^2(s_2^*)^2)\bigr) + \bigl(-(s_2^*)^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 3 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 - c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2(s_2^*)^2u - s_1^2c_2^2(s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{def_complex_difference}\ \text{を 3 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2c_1s_1(c_2s_2^*)s_2^*u - s_1^2(c_2s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2^*s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \text{上の}\ c_2s_2^* = c_2^*\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2c_1c_2^*s_1s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&\quad= c_1^2(c_2^*)^2 + \bigl(-(2c_1c_2^*s_1s_2^*u)\bigr) + s_1^2(s_2^*)^2u^2 + \bigl(-(c_1^2(s_2^*)^2u^2)\bigr) + 2c_1c_2^*s_1s_2^*u \\
&\qquad\quad + \bigl(-(s_1^2(c_2^*)^2)\bigr) + \bigl(-(s_2^*)^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{def_complex_difference}\ \text{を 4 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})(2c_1c_2^*s_1s_2^*u) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 2c_1c_2^*s_1s_2^*u \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 4 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 + \bigl((-1_{\mathbb{C}})(2c_1c_2^*s_1s_2^*u) + 2c_1c_2^*s_1s_2^*u\bigr) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 + \bigl(-(2c_1c_2^*s_1s_2^*u) + 2c_1c_2^*s_1s_2^*u\bigr) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one})\\
&\quad= c_1^2(c_2^*)^2 + 0_{\mathbb{C}} + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr)
 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&\quad= c_1^2(c_2^*)^2 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr)
 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&\quad= c_1^2(c_2^*)^2 + \bigl((-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2\bigl((s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})c_1^2\bigr)\bigl((s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl(s_1^2 + (-1_{\mathbb{C}})c_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を 2 箇所へ})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の可換律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + 1_{\mathbb{C}}s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + \bigl((-1)(-1)\bigr)_{\mathbb{C}}s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則}\ 1 = (-1)(-1))\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})c_1^2 + (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&\quad= \bigl(c_1^2 + (-s_1^2)\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 + (-s_1^2)\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&\quad= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 - s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ})\\
&\quad= 1_{\mathbb{C}}(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}})1_{\mathbb{C}} + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \text{上の}\ c_1^2 - s_1^2 = 1\ \text{を 2 箇所へ})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}}) + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1) + 1\bigr)_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + 0_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則}\ (-1) + 1 = 0)\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + 0_{\mathbb{C}}
&&(\because\ \blkref{complex_zero_times_is_zero})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&\quad= (c_2^*)^2 + \bigl(-(s_2^*)^2\bigr)
&&(\because\ \blkref{multiply_by_minus_one})\\
&\quad= (c_2^*)^2 - (s_2^*)^2
&&(\because\ \blkref{def_complex_difference})\\
&\quad= 1
&&(\because\ \text{上の}\ (c_2^*)^2 - (s_2^*)^2 = 1)
\end{aligned}`),
      paragraph(["第 1 の等式は、主張の左辺から次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\det A(\theta)
&= \det\begin{pmatrix}
   \gamma_1(\theta) & \gamma_2(\theta) \\
   -\gamma_2(-\theta) & \gamma_1(\theta)
   \end{pmatrix}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= \gamma_1(\theta)\gamma_1(\theta) - \gamma_2(\theta)\bigl(-\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{def_det_two_by_two})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(-\bigl(\gamma_2(\theta)(-\gamma_2(-\theta))\bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference})\\
&= \gamma_1(\theta)\gamma_1(\theta) + (-1_{\mathbb{C}})\Bigl(\gamma_2(\theta)\bigl((-1_{\mathbb{C}})\gamma_2(-\theta)\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl((-1)(-1)\bigr)_{\mathbb{C}}\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \gamma_1(\theta)\gamma_1(\theta) + 1_{\mathbb{C}}\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz)\\
&= 1
&&(\because\ \text{上の第 2 の等式の鎖})
\end{aligned}`),
      paragraph([
        "第 3 の等式。",
        ref("eigenvector_of_A_theta_tilde"),
        " より ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta) \pm r \in \mathbb{R}`),
        "、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) より ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta) = -r^2`),
        " である。まず ",
        math(String.raw`\mathbb{C}`),
        " の中で",
      ]),
      displayMath(String.raw`\begin{aligned}
(\lambda_{+,\mu}\lambda_{-,\mu})_{\mathbb{C}}
&= (\lambda_{+,\mu})_{\mathbb{C}}\,(\lambda_{-,\mu})_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(\gamma_1(\theta) + r\bigr)_{\mathbb{C}}\,\bigl(\gamma_1(\theta) - r\bigr)_{\mathbb{C}}
&&(\because\ \blkref{eigenvector_of_A_theta_tilde})\\
&= \bigl(\gamma_1(\theta) + r\bigr)\bigl(\gamma_1(\theta) - r\bigr)
&&(\because\ \text{準備の像の読み方（和・差の像は像の和・差。以下この鎖では像の記号を省く）})\\
&= \gamma_1(\theta)\gamma_1(\theta) - \gamma_1(\theta)r + r\gamma_1(\theta) - rr
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&= \gamma_1(\theta)\gamma_1(\theta) - r\gamma_1(\theta) + r\gamma_1(\theta) - rr
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= \gamma_1(\theta)\gamma_1(\theta) - rr
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元と零元})\\
&= \gamma_1(\theta)^2 - r^2
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz\ \text{を 2 箇所へ})\\
&= \gamma_1(\theta)^2 + \bigl(-r^2\bigr)
&&(\because\ \blkref{def_complex_difference})\\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (2))\\
&= 1_{\mathbb{C}}
&&(\because\ \text{上の第 2 の等式の鎖})
\end{aligned}`),
      paragraph(["であり、これを実数の対として読むと"]),
      displayMath(String.raw`\begin{aligned}
(\lambda_{+,\mu}\lambda_{-,\mu},\ 0)
&= (\lambda_{+,\mu}\lambda_{-,\mu})_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{直前の鎖})\\
&= (1,\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        "となる。",
        ref("definition_of_cc"),
        " の台集合 ",
        math(String.raw`\mathbb{R}^2`),
        " の元は成分がすべて等しいときに限り等しいので、第 1 成分を比べて ",
        math(String.raw`\lambda_{+,\mu}\lambda_{-,\mu} = 1`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の等式）を得る。",
      ]),
      paragraph(["最後の等式。まず ", math(String.raw`\mathbb{C}`), " の中で"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\gamma_1(\theta)^2\bigr)_{\mathbb{C}}
&= \bigl(\gamma_1(\theta)\gamma_1(\theta)\bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の冪}\ x^2 = xx)\\
&= \gamma_1(\theta)_{\mathbb{C}}\,\gamma_1(\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(\gamma_1(\theta)_{\mathbb{C}}\bigr)^2
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ zz = z^2)\\
&= \gamma_1(\theta)^2 + 0_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元。以下この鎖では像の記号を省き、最後の 4 行で書き戻す})\\
&= \gamma_1(\theta)^2 + \bigl(-r^2 + r^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \gamma_1(\theta)^2 + \bigl(\gamma_2(\theta)\gamma_2(-\theta) + r^2\bigr)
&&(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (2))\\
&= \bigl(\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)\bigr) + r^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= 1_{\mathbb{C}} + \bigl(r_{\mathbb{C}}\bigr)^2
&&(\because\ \text{上の第 2 の等式の鎖})\\
&= 1_{\mathbb{C}} + r_{\mathbb{C}}\,r_{\mathbb{C}}
&&(\because\ \blkref{def_power_of_complex_number}\ \text{より}\ z^2 = zz)\\
&= 1_{\mathbb{C}} + (rr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= (1 + rr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&= \bigl(1 + r^2\bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の冪}\ xx = x^2)
\end{aligned}`),
      paragraph([
        "であり、第 3 の等式と同じく ",
        ref("inclusion_rr_to_cc"),
        " の対の第 1 成分を比べて ",
        math(String.raw`\gamma_1(\theta)^2 = 1 + r^2 = 1 + \left|\gamma_2(\theta)\right|^2`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の等式）を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "det_A_theta（008 章）の Step 0〜Step 6 と同じ計算である。θ_μ 固有の性質は使われておらず、" +
          "θ ∈ R の恒等式として成立することを本文で明示した。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（残差 ≤ 1.4e-12）。式変形の各行の厳密な検算は sagemath/check/det_A_theta_tilde/。",
        "2026-08-19 の式変形統一で、Step 3 の展開 2 式と Step 4 の鎖の先頭行に行末根拠を補い、" +
          "散文で畳まれていた γ_1(θ)^2 = 1 + r^2 の導出を主張の左辺から始まる三段の鎖へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: SageMath の検算（sagemath/check/det_A_theta_tilde/）を付けるときに証明を直した。Step 0〜Step 6 の散文のつなぎを、準備（像の読み方）と、−(−z) = z・ii = −1_C・e_+e_− = 1_C・u^2 + v^2 = 1_C・γ_2(θ)・γ_2(−θ)・(a_0 − iv)(a_0 + iv)・γ_2(θ)γ_2(−θ)・三つの双曲線の関係の鎖と、主張の左辺から始まる四本の鎖に組み直した。" +
          "e_+e_− = 1 の根拠を行列の theorem_exp_product（n=1）・theorem_exp_zero から scalar_exp_product・scalar_exp_zero に、u^2 + v^2 = 1 を根拠の無い前提から euler_formula_cos_sin による u + iv = e_+ と exp_of_negative_i_real_as_cos_minus_i_sin の鎖に（商は乗法の逆元との積として準備に置いた）、γ_2(−θ) の表示を根拠の無い代入から def_gamma1_gamma2_of_theta と def_A_theta の (2,1) 成分の比較に直し、一行に束ねていた並べ替え・相殺・くくり出しを一操作ずつに分けた。" +
          "第 3・第 4 の等式は ℂ の中で示してから inclusion_rr_to_cc の対の第 1 成分で ℝ の等式に戻した。主張に、どの等式が ℂ と ℝ のどちらのものかを書いた（中身は不変）。",
      ],
    },
  },
  {
    id: "Athetatilde_007_claim_gamma1_gt_1",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 9 },
    title: { tex: String.raw`\gamma_1(\tilde\theta_\mu) > 1` },
    labels: ["gamma1_gt_1_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1, \qquad \text{さらに} \qquad \gamma_1(\tilde\theta_\mu) > 1`),
      paragraph([
        "が成り立つ。狭義の不等号は ",
        ref("gamma_2_theta_tilde_nonzero"),
        " による。これは後段で最大固有値の一意性に使う。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1(\tilde\theta_\mu) > 0`),
        "）。",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\cosh x - \sinh x = \exp(-x) > 0`),
        "（",
        ref("cosh_sinh_basic_properties"),
        "）なので ",
        math(String.raw`c_1 > s_1 > 0`),
        "、",
        math(String.raw`c_2^* > s_2^* > 0`),
        "（",
        math(String.raw`K_1 > 0`),
        " と、",
        ref("def_second_dual_coupling_constant"),
        " による ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`s_1, s_2^* > 0`),
        "）。また ",
        math(String.raw`\cos\tilde\theta_\mu \leq 1`),
        " である。",
        ref("def_gamma1_gamma2_of_theta"),
        " の定義から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\tilde\theta_\mu)
&= c_1c_2^* - s_1s_2^*\cos\tilde\theta_\mu
   \quad (\because \gamma_1 \text{ の定義}) \\
&\geq c_1c_2^* - s_1s_2^*
   \quad (\because \cos\tilde\theta_\mu \leq 1 \text{ かつ } s_1s_2^* > 0) \\
&> s_1s_2^* - s_1s_2^*
   \quad (\because c_1 > s_1 > 0,\ c_2^* > s_2^* > 0 \text{ より } c_1c_2^* > s_1s_2^*) \\
&= 0
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2 > 1`),
        "）。主張の左辺から",
        ref("det_A_theta_tilde"),
        " と ",
        ref("gamma_2_theta_tilde_nonzero"),
        " を順に引くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\tilde\theta_\mu)^2
&= 1 + \left|\gamma_2(\tilde\theta_\mu)\right|^2
   \quad (\because \det A(\tilde\theta_\mu)=1 \text{ と固有値の積}) \\
&> 1 + 0
   \quad (\because \gamma_2(\tilde\theta_\mu)\ne0 \text{ より } \left|\gamma_2(\tilde\theta_\mu)\right|^2>0) \\
&= 1
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（結論）。",
        math(String.raw`t := \gamma_1(\tilde\theta_\mu) > 0`),
        " と置く。Step 2 より ",
        math(String.raw`t^2>1`),
        " である。一方、",
        math(String.raw`t \leq 1`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
t^2
&= t\cdot t
   \quad (\because \text{平方の定義}) \\
&\leq 1\cdot t
   \quad (\because t\leq1 \text{ の両辺に }0<t\text{ を掛ける}) \\
&\leq 1\cdot1
   \quad (\because t\leq1 \text{ の両辺に }0<1\text{ を掛ける}) \\
&= 1
   \quad (\because \mathbb{R} \text{ の乗法単位元})
\end{aligned}`,
      ),
      paragraph([
        "となり Step 2 の ",
        math(String.raw`t^2>1`),
        " と矛盾する。したがって ",
        math(String.raw`t>1`),
        "、すなわち ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)>1`),
        " である。さらに ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1`),
        " は狭義不等式から従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（16 組の (K_1,K_2)、M = 2..8 の全 μ で " +
          "min(γ_1(θ~_μ) − 1) ≥ 1.3e-2 > 0。臨界点ちょうどでも狭義に正）。同じ K で整数運動量 θ = 2π では " +
          "臨界点で γ_1 = 1 になる（check_05 の対比表）。",
        "2026-08-19 の式変形統一で、Step 1 の正値性を一操作ずつの鎖へ分け、Step 2 の平方評価と Step 3 の背理法を主張の左辺から始まる鎖へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。" +
          "Step 1 で出典なしに使っていた K_2^* > 0 に def_second_dual_coupling_constant の参照を付けた。",
      ],
    },
  },
  {
    id: "Athetatilde_008_claim_gamma_theta_tilde_positive",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 10 },
    title: { tex: String.raw`\gamma(\tilde\theta_\mu) > 0` },
    labels: ["gamma_theta_tilde_mu_positive"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とする。",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma`),
        " の ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " での値 ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\gamma(\tilde\theta_\mu) > 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_gamma_theta"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) \geq 0`),
        " である。",
        math(String.raw`\gamma(\tilde\theta_\mu) = 0`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\tilde\theta_\mu)
&= \cosh\gamma(\tilde\theta_\mu)
&&(\because\ \blkref{def_gamma_theta}\ (\cosh\gamma(\theta) = \gamma_1(\theta))\ \text{を}\ \theta = \tilde\theta_\mu\ \text{に適用})\\
&= \cosh 0
&&(\because\ \text{仮定}\ \gamma(\tilde\theta_\mu) = 0)\\
&= \frac{\exp 0 + \exp(-0)}{2}
&&(\because\ \blkref{def_cosh_sinh})\\
&= \frac{\exp 0 + \exp 0}{2}
&&(\because\ -0 = 0)\\
&= \frac{1 + 1}{2}
&&(\because\ \blkref{scalar_exp_zero})\\
&= 1
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`,
      ),
      paragraph([
        "となり、",
        ref("gamma1_gt_1_theta_tilde"),
        " の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) > 1`),
        " に矛盾する。よって ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "def_gamma_theta_mu（008 章）と同じ arccosh の使い方に揃えたうえで、半整数運動量に固有の帰結" +
          "「γ(θ~_μ) > 0（狭義）」を statement に含めた。C′-15（最大固有値の一意性）で使う。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: γ(θ~_μ) := arccosh(γ_1(θ~_μ)) の定義を def_gamma_theta（θ∈ℝ の γ(θ) の定義）へまとめ、" +
          "このブロックには γ(θ~_μ) > 0 の主張だけを残した（1 ブロック 1 主張）。中身に合わせ、ラベルを def_gamma_theta_tilde_mu から gamma_theta_tilde_mu_positive へ、" +
          "id を Athetatilde_008_definition_gamma_theta_tilde から Athetatilde_008_claim_gamma_theta_tilde_positive へ改めた。" +
          "statement の括弧書きにあった背理法を、式変形の形で証明へ移した。中身は変えていない。",
      ],
    },
  },
  {
    id: "Athetatilde_009_claim_lambda_eq_exp_gamma",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 11 },
    title: { tex: String.raw`\lambda_{\pm,\mu} = \exp(\pm\gamma(\tilde\theta_\mu))` },
    labels: ["lambda_eq_exp_gamma_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\lambda_{+,\mu} = \exp(+\gamma(\tilde\theta_\mu)), \qquad
\lambda_{-,\mu} = \exp(-\gamma(\tilde\theta_\mu))`,
      ),
      paragraph(["が成り立つ。とくに ", math(String.raw`\gamma(\tilde\theta_\mu) > 0`), " なので"]),
      displayMath(String.raw`\lambda_{+,\mu} > 1 > \lambda_{-,\mu} > 0`),
      paragraph([
        "であり、2 つの固有値は**必ず分離している**。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`g_1 := \gamma_1(\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |\gamma_2(\tilde\theta_\mu)| > 0`),
        "、",
        math(String.raw`\gamma := \gamma(\tilde\theta_\mu) > 0`),
        " と略記する（",
        ref("def_gamma_theta"),
        "、",
        ref("gamma_theta_tilde_mu_positive"),
        "）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\sinh\gamma = r`),
        "）。",
        ref("def_gamma_theta"),
        " より ",
        math(String.raw`\cosh\gamma = g_1`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh^2 - \sinh^2 = 1`),
        " と ",
        ref("det_A_theta_tilde"),
        " の ",
        math(String.raw`g_1^2 = 1 + r^2`),
        " から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sinh\gamma\right)^2
&= \left(\cosh\gamma\right)^2 - 1
   \quad (\because \text{cosh\_sinh\_basic\_properties}\ (\cosh^2 - \sinh^2 = 1)) \\
&= g_1^2 - 1
   \quad (\because \text{def\_gamma\_theta}\ (\cosh\gamma = g_1)) \\
&= \left(1 + r^2\right) - 1
   \quad (\because \text{det\_A\_theta\_tilde}\ (g_1^2 = 1 + r^2)) \\
&= r^2
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\gamma > 0`),
        " より ",
        math(String.raw`\sinh\gamma = \frac{1}{2}(\exp(\gamma) - \exp(-\gamma)) > 0`),
        " であり、",
        math(String.raw`r > 0`),
        " でもあるから、非負の平方根の一意性（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）より ",
        math(String.raw`\sinh\gamma = r`),
        "。",
      ]),
      paragraph([
        "Step 2（結論）。",
        math(String.raw`\exp(\pm\gamma) = \cosh\gamma \pm \sinh\gamma`),
        "（",
        ref("cosh_sinh_basic_properties"),
        "）と Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(+\gamma)
&= \cosh\gamma + \sinh\gamma
   \quad (\because \text{cosh\_sinh\_basic\_properties}) \\
&= g_1 + \sinh\gamma
   \quad (\because \text{def\_gamma\_theta}\ (\cosh\gamma = g_1)) \\
&= g_1 + r
   \quad (\because \text{Step 1}) \\
&= \lambda_{+,\mu}
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde}) \\
\exp(-\gamma)
&= \cosh\gamma - \sinh\gamma
   \quad (\because \text{cosh\_sinh\_basic\_properties}) \\
&= g_1 - \sinh\gamma
   \quad (\because \text{def\_gamma\_theta}\ (\cosh\gamma = g_1)) \\
&= g_1 - r
   \quad (\because \text{Step 1}) \\
&= \lambda_{-,\mu}
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\lambda_{\pm,\mu} = g_1 \pm r`),
        " は ",
        ref("eigenvector_of_A_theta_tilde"),
        "。）",
      ]),
      paragraph([
        "Step 3（分離）。",
        math(String.raw`\gamma > 0`),
        " と実指数関数の狭義単調増加性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(\gamma)
&> \exp(0)
   \quad (\because \gamma>0 \text{ と実指数関数の狭義単調増加性}) \\
\exp(0)
&= 1
   \quad (\because \exp(0)=1) \\
1=\exp(0)
&> \exp(-\gamma)
   \quad (\because 0>-\gamma \text{ と実指数関数の狭義単調増加性}) \\
\exp(-\gamma)
&> 0
   \quad (\because \text{実指数関数の正値性})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の lambda_eq_exp_gamma は「λ_+λ_- = 1 かつ λ_+ + λ_- = 2γ_1 ≥ 2 > 0 なので両固有値は正」" +
          "という筋で書かれていたが、ここでは sinh γ = |γ_2| を経由して e^{±γ} = cosh γ ± sinh γ から直接出した" +
          "（半整数運動量では γ > 0 が確定しているので分離まで一気に言える）。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_05（cosh γ = γ_1、sinh γ = |γ_2|、λ_± = e^{±γ}、" +
          "min γ(θ~_μ) ≥ 3.0e-1 > 0、残差 ≤ 1e-12）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 2 },
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{ を導入して } V^{(+)} = c\,\check{V}' \text{ を示す道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("T_V_plus_check_Z_Y"),
        " で ",
        math(String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A(\tilde\theta_\mu)`),
        " を、",
        ref("diagonalization_check_P_D"),
        " で ",
        math(String.raw`A(\tilde\theta_\mu) = \check{P}_\mu \check{D}_\mu \check{P}_\mu^{-1}`),
        " を得た。以下では、",
        math(String.raw`\check{P}_\mu`),
        " の列で ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を組み替えた ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " を導入し、",
      ]),
      displayMath(
        String.raw`\check{V}' := \exp\!\left(\sum_{\mu \in \check{\mathcal{M}}}
\gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
- \tfrac12 I\right)\right)`,
      ),
      paragraph([
        "とおいたとき、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について ",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " が成り立つこと（",
        ref("V_plus_eq_c_check_Vprime"),
        "）まで到達し、最後にこれを ",
        math(String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " で書き直す。",
        math(String.raw`c`),
        " の値の決定は次の章で扱う。",
      ]),
      paragraph([
        "**場合分けは一つも要らない。** ",
        ref("gamma_2_theta_tilde_nonzero"),
        " により ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が**すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とすべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点を含む）について**成り立つので、",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " はすべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について定義され、",
        math(String.raw`\check{V}'`),
        " の和も ",
        math(String.raw`\check{\mathcal{M}}`),
        " 全体にわたる。",
      ]),
      paragraph([
        "**平方根の分枝の議論も要らない。** ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4)(5) により根号が ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`i\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定しているので、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分は実の絶対値だけで書かれており、",
        math(String.raw`\check\psi`),
        " どうしの反交換関係を計算するときに分枝の問題が生じない。",
      ]),
      paragraph([
        "**対になる添字は ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " である。** ",
        ref("conjugate_index_of_check_Z_Y"),
        " の ",
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu`),
        " と ",
        ref("anticommutator_of_check_Z_Y"),
        " の ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " に対応する。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまるので、**以下では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字が現れない。**",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: 章立ての組み直しで、旧い章「ψ̌_μ, ψ̌_μ^† と V^{(+)} = c V̌'」の案内文をこの章の ψ̌ の定義の前へ移した。題を式で指すものにし、「この章」を「以下」に、「次章」を「次の章」に直し、「半整数運動量のフェルミオン」「フェルミオン」の語を外し、章の最後で ň_μ による書き直しを置くことを書き足した。",
      ],
    },
  },
  {
    id: "evenfermi_001_definition_check_fermi",
    kind: "definition",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 3 },
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{（}\check{Z}_\mu, \check{Y}_\mu\text{ の一次結合）}` },
    labels: ["def_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " を用いて ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}
:= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu`,
      ),
      paragraph([
        "すなわち（",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記して）",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger := \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M_{\mathrm{col}}}}\,\check{Y}_\mu,
\qquad
\check\psi_\mu := \frac{+r}{2\sqrt{M_{\mathrm{col}}}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M_{\mathrm{col}}}}\,\check{Y}_\mu`,
      ),
      paragraph([
        "と定める（行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        "・",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        " を続けて展開した ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix} = (pA + rB,\ qA + sB)`),
        "）。",
      ]),
      paragraph([
        "**この定義は ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " のすべてについて意味をもつ。** ",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " すなわち ",
        math(String.raw`r > 0`),
        "、",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b \neq 0`),
        " であり、",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " より ",
        math(String.raw`\sqrt{M_{\mathrm{col}}} > 0`),
        " なので分母 ",
        math(String.raw`2\sqrt{M_{\mathrm{col}}}\,b`),
        " は ",
        math(String.raw`0`),
        " でない（",
        ref("diagonalization_check_P_D"),
        " の Step 1）。したがって**除外される ",
        math(String.raw`\mu`),
        " は無い**。",
      ]),
      paragraph([
        math(String.raw`\dagger`),
        " は転置共役を表す記号ではなく、2 つの元を区別する添え字の一部として使う。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_fermi の半整数運動量版。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ_μ)γ_2(−θ_μ))/(2√M γ_2(−θ_μ)) は、" +
          "relation_of_gamma_2_theta_tilde (5)（√(γ_2 γ_2(−)) = i|γ_2|）により半整数運動量では −|γ_2|/(2√M γ_2(−θ~_μ)) に等しい。" +
          "したがって定義式の形は 008 章と同一であり、根号が実の絶対値に書き換わっているだけである。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01（定義式と P̌_μ の列の一致、および ψ̌ の M 周期性）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_002_claim_periodicity",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 4 },
    title: { tex: String.raw`\gamma_1, \gamma_2 \text{ の周期性と共役添字 } M_{\mathrm{col}}+1-\mu` },
    labels: ["periodicity_of_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。次が成り立つ。",
      ]),
      list([
        [
          "(1) **",
          math(String.raw`\gamma_1, \gamma_2`),
          " の ",
          math(String.raw`2\pi`),
          " 周期性**（",
          math(String.raw`\theta \in \mathbb{R}`),
          "、",
          math(String.raw`k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\gamma_1(\theta + 2k\pi) = \gamma_1(\theta)`),
          "、",
          math(String.raw`\gamma_2(\theta + 2k\pi) = \gamma_2(\theta)`),
          "。",
        ],
        [
          "(2) **添字の ",
          math(String.raw`M_{\mathrm{col}}`),
          " 周期性**（",
          math(String.raw`\mu, k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\tilde\theta_{\mu+kM_{\mathrm{col}}} = \tilde\theta_\mu + 2k\pi`),
          "、したがって ",
          math(String.raw`\gamma_1(\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(\pm\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_2(\pm\tilde\theta_\mu)`),
          "。",
        ],
        [
          "(3) **共役添字**（",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          "）：",
          math(String.raw`\gamma_2(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_2(-\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(-\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_2(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_1(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\check{P}_{M_{\mathrm{col}}+1-\mu}`),
          " は ",
          math(String.raw`\check{P}_\mu`),
          " の ",
          math(String.raw`\gamma_2(\pm\tilde\theta_\mu)`),
          " を入れ替えたもの。",
        ],
      ]),
      paragraph([
        "**この主張の (2) だけは ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " で量化する。** ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字を扱う主張には、この (2) のほかに ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        " がある。(2) は ",
        math(String.raw`\gamma_1, \gamma_2`),
        " が ",
        math(String.raw`\theta \in \mathbb{R}`),
        " の関数（",
        ref("def_gamma1_gamma2_of_theta"),
        "）であることによって意味をもつ主張であり、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " や ",
        math(String.raw`\check\psi_\mu`),
        "（これらは ",
        math(String.raw`\check{\mathcal{M}}`),
        " 上でしか定義していない）には言及していない。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) 実数 ",
        math(String.raw`t`),
        " について ",
        math(String.raw`\cos(t+2k\pi) = \cos t`),
        "、",
        math(String.raw`\sin(t+2k\pi) = \sin t`),
        " であり、",
        ref("euler_formula_cos_sin"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(i(t+2k\pi))
&= \cos(t+2k\pi) + i\sin(t+2k\pi)
   \quad (\because \blkref{euler_formula_cos_sin}) \\
&= \cos t + i\sin t
   \quad (\because \cos, \sin \text{ の } 2\pi \text{ 周期性}) \\
&= \exp(it)
   \quad (\because \blkref{euler_formula_cos_sin})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " と ",
        math(String.raw`\gamma_2(\theta) = i\exp(i\theta)s_2^*\left(c_1\cos\theta - i\sin\theta - s_1c_2\right)`),
        " は ",
        math(String.raw`\cos\theta, \sin\theta, \exp(i\theta)`),
        " のみを通じて ",
        math(String.raw`\theta`),
        " に依存するから、(1) が従う。",
      ]),
      paragraph([
        "(2) ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{\mu+kM_{\mathrm{col}}}
&= \frac{2\pi\left(\mu+kM_{\mathrm{col}}-\frac12\right)}{M_{\mathrm{col}}}
   \quad (\because \blkref{antiperiodic_exp_sum}) \\
&= \frac{2\pi\left(\mu-\frac12\right) + 2\pi kM_{\mathrm{col}}}{M_{\mathrm{col}}}
   \quad (\because \mathbb{R}\text{ の分配則}) \\
&= \frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}} + \frac{2\pi kM_{\mathrm{col}}}{M_{\mathrm{col}}}
   \quad (\because \text{分数の和（分母 }M_{\mathrm{col}}\neq0\text{）}) \\
&= \tilde\theta_\mu + \frac{2\pi kM_{\mathrm{col}}}{M_{\mathrm{col}}}
   \quad (\because \blkref{antiperiodic_exp_sum}) \\
&= \tilde\theta_\mu + 2k\pi
   \quad (\because M_{\mathrm{col}}\neq0\text{ による約分})
\end{aligned}`,
      ),
      paragraph([
        "これを (1) に ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " として使えば ",
        math(String.raw`\gamma_1(\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_1(\tilde\theta_\mu)`),
        " と ",
        math(String.raw`\gamma_2(\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_2(\tilde\theta_\mu)`),
        "。また ",
        math(String.raw`-\tilde\theta_{\mu+kM_{\mathrm{col}}} = -\tilde\theta_\mu + 2(-k)\pi`),
        " なので (1) を ",
        math(String.raw`\theta = -\tilde\theta_\mu`),
        "、",
        math(String.raw`k \to -k`),
        " として使えば ",
        math(String.raw`\gamma_2(-\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_2(-\tilde\theta_\mu)`),
        "。",
      ]),
      paragraph([
        "(3) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (1) より ",
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu = \left(-\tilde\theta_\mu\right) + 2\pi`),
        " である。よって (1) を ",
        math(String.raw`\theta = -\tilde\theta_\mu`),
        "、",
        math(String.raw`k = 1`),
        " として使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&= \gamma_2\!\left(\left(-\tilde\theta_\mu\right) + 2\pi\right)
   \quad (\because\ \blkref{conjugate_index_of_check_Z_Y}\ (1)) \\
&= \gamma_2(-\tilde\theta_\mu)
   \quad (\because \text{本ブロックの (1)}\ (k=1))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
-\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= -(2\pi-\tilde\theta_\mu)
   \quad (\because\ \blkref{conjugate_index_of_check_Z_Y}\ (1)) \\
&= -2\pi+\tilde\theta_\mu
   \quad (\because \mathbb{R}\text{ の分配則}) \\
&= \tilde\theta_\mu+2(-1)\pi
   \quad (\because \mathbb{R}\text{ の加法の可換則と }-2\pi=2(-1)\pi),\\[4pt]
\gamma_2(-\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&= \gamma_2(\tilde\theta_\mu+2(-1)\pi)
   \quad (\because \text{上の等式}) \\
&= \gamma_2(\tilde\theta_\mu)
   \quad (\because \text{本ブロック }(1)),\\[4pt]
\gamma_1(\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&= \gamma_1((-\tilde\theta_\mu)+2\pi)
   \quad (\because\ \blkref{conjugate_index_of_check_Z_Y}\ (1)) \\
&= \gamma_1(-\tilde\theta_\mu)
   \quad (\because \text{本ブロック }(1)) \\
&= \gamma_1(\tilde\theta_\mu)
   \quad (\because \cos(-t)=\cos t\text{ と }\blkref{def_gamma1_gamma2_of_theta}\text{ の }\gamma_1\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので ",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \mathrm{arccosh}\!\left(\gamma_1(\tilde\theta_{M_{\mathrm{col}}+1-\mu})\right)`),
        " が定義されており、これは ",
        math(String.raw`\gamma_1`),
        " の値だけで決まるので ",
        math(String.raw`\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma(\tilde\theta_\mu)`),
        "。",
      ]),
      paragraph([
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分は ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`M_{\mathrm{col}}`),
        " だけで書かれているので、上の 2 式を代入すれば ",
        math(String.raw`\check{P}_{M_{\mathrm{col}}+1-\mu}`),
        " の成分が ",
        math(String.raw`\left|\gamma_2(-\tilde\theta_\mu)\right|`),
        " と ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)`),
        " で書けることが分かる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では対応する事実が gamma2_theta_M_periodicity と hatZ_hatY_M_periodicity に分かれ、" +
          "action_of_T_Vprime_on_psi の proof の中で μ の符号ごとの場合分け（a)〜c)）として使われていた。" +
          "半整数運動量では添字を 𝓜̌ = {1,…,M} に絞り、共役添字を M+1−μ で取ることで場合分けが要らない。",
        "以前この主張は ψ̌_{μ+kM} = ψ̌_μ（μ ∈ Z）を含んでいたが、共役添字を 1−μ から M+1−μ へ書き換えたことで " +
          "ψ̌ を 𝓜̌ の外の添字で評価する箇所が本文から消えたため、その項目は不要になった。" +
          "γ_1, γ_2 は θ ∈ R の関数なので (2) だけは μ ∈ Z のまま残してある。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01。",
        "2026-08-19 の式変形統一で、周期性の鎖の機械識別子を人間可読な根拠へ直し、根拠の無かった分配則の行を補った。" +
          "また、「同じ計算」に省略していた共役添字の二本の導出を、各結論の左辺から始まる鎖へ開いた。内容と参照は変えていない。",
      ],
    },
  },
  {
    id: "evenfermi_003_claim_anticommutator",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 5 },
    title: { tex: String.raw`\check\psi \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0,
\qquad
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+ = \delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I,
\qquad
\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
        " は ",
        ref("anticommutator_of_check_Z_Y"),
        " と同じ通常のクロネッカーのデルタ）。反交換子は ",
        ref("def_matrix_anticommutator"),
        "、右辺の ",
        math(String.raw`0`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列 ",
        math(String.raw`O \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " である。対になる添字は ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " である。",
        ref("def_check_index_set"),
        " (5) により、この対の条件は合同式なしで書ける。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`a_\mu := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b_\mu := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r_\mu := |a_\mu| \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`c_\mu := \dfrac{1}{2\sqrt{M_{\mathrm{col}}}\,b_\mu} \in \mathbb{C}^\times`),
        " と略記する（",
        ref("gamma_2_theta_tilde_nonzero"),
        " と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`a_\mu \neq 0`),
        "、",
        math(String.raw`b_\mu \neq 0`),
        "）。",
        ref("def_check_fermi"),
        " は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\mu^\dagger &= c_\mu\left(-r_\mu\,\check{Z}_\mu + b_\mu\,\check{Y}_\mu\right)
&&\bigl(\because\ \blkref{def_check_fermi}\text{ と上の略記}\bigr),\\
\check\psi_\mu &= c_\mu\left(+r_\mu\,\check{Z}_\mu + b_\mu\,\check{Y}_\mu\right)
&&\bigl(\because\ \blkref{def_check_fermi}\text{ と上の略記}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "と書ける。また ",
        ref("anticommutator_of_check_Z_Y"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Z}_\nu\right]_+ &= 2M_{\mathrm{col}}\,\delta\,I
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\bigr),\\
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+ &= 0
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\bigr),\\
\left[\check{Y}_\mu,\check{Z}_\nu\right]_+ &= 0
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\text{ と反交換子の対称性}\bigr),\\
\left[\check{Y}_\mu,\check{Y}_\nu\right]_+ &= 2M_{\mathrm{col}}\,\delta\,I
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\bigr),\\
\delta &:= \delta_{\nu,\,M_{\mathrm{col}}+1-\mu}
&&\bigl(\because\ \text{略記}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`[\check{Y}_\mu, \check{Z}_\nu]_+ = [\check{Z}_\nu, \check{Y}_\mu]_+ = 0`),
        " は反交換子の対称性による）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\delta \neq 0`),
        " のときの係数の関係）。",
        math(String.raw`\delta = \delta_{\nu,\,M_{\mathrm{col}}+1-\mu} = 1`),
        " とは ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " そのものである（",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " に絞ったので合同式を解く必要がない。",
        ref("def_check_index_set"),
        " (5)）。このとき ",
        ref("periodicity_of_check_fermi"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a_\nu
&= \gamma_2(\tilde\theta_{M_{\mathrm{col}}+1-\mu})
   \quad (\because a_\nu := \gamma_2(\tilde\theta_\nu),\ \nu = M_{\mathrm{col}}+1-\mu) \\
&= \gamma_2(-\tilde\theta_\mu)
   \quad (\because \blkref{periodicity_of_check_fermi}\ (3)) \\
&= b_\mu
   \quad (\because b_\mu \text{ の略記}),\\[4pt]
b_\nu
&= \gamma_2(-\tilde\theta_{M_{\mathrm{col}}+1-\mu})
   \quad (\because b_\nu := \gamma_2(-\tilde\theta_\nu),\ \nu = M_{\mathrm{col}}+1-\mu) \\
&= \gamma_2(\tilde\theta_\mu)
   \quad (\because \blkref{periodicity_of_check_fermi}\ (3)) \\
&= a_\mu
   \quad (\because a_\mu \text{ の略記})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`b_\mu = -\overline{a_\mu}`),
        " と ",
        math(String.raw`|\overline{z}| = |z|`),
        "（",
        ref("abs_basic_properties"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
r_\nu
&= |a_\nu|
   \quad (\because r_\nu := |a_\nu|) \\
&= |b_\mu|
   \quad (\because \text{上の } a_\nu = b_\mu) \\
&= \left|-\overline{a_\mu}\right|
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (1)) \\
&= \left|\overline{a_\mu}\right|
   \quad (\because \blkref{abs_basic_properties}\ (|-z| = |z|)) \\
&= |a_\mu|
   \quad (\because \blkref{abs_basic_properties}\ (|\bar z| = |z|)) \\
&= r_\mu
   \quad (\because r_\mu := |a_\mu|)
\end{aligned}`,
      ),
      paragraph([
        "である。以下この共通の値を ",
        math(String.raw`r := r_\mu = r_\nu > 0`),
        " と書く。さらに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
b_\mu b_\nu
&= b_\mu a_\mu
   \quad (\because \text{上の } b_\nu = a_\mu) \\
&= a_\mu b_\mu
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= -r^2
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (2)),\\[4pt]
c_\mu c_\nu
&= \frac{1}{2\sqrt{M_{\mathrm{col}}}\,b_\mu}\cdot\frac{1}{2\sqrt{M_{\mathrm{col}}}\,b_\nu}
   \quad (\because c_\mu := \tfrac{1}{2\sqrt{M_{\mathrm{col}}}\,b_\mu}) \\
&= \frac{1}{4M_{\mathrm{col}}\,b_\mu b_\nu}
   \quad \left(\because \left(2\sqrt{M_{\mathrm{col}}}\right)^2 = 4M_{\mathrm{col}}\right) \\
&= \frac{1}{4M_{\mathrm{col}}\left(-r^2\right)}
   \quad (\because \text{上の } b_\mu b_\nu = -r^2) \\
&= \frac{-1}{4M_{\mathrm{col}}r^2}
   \quad (\because \text{負号を分子へ移す（}\mathbb{C}\text{ の四則）})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`r > 0`),
        " なので分母は ",
        math(String.raw`0`),
        " でない）。",
      ]),
      paragraph([
        "Step 2（第 1 式）。反交換子 ",
        math(String.raw`[X,W]_+ := XW + WX`),
        " は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型である。実際",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\alpha X, \beta W]_+
&= (\alpha X)(\beta W) + (\beta W)(\alpha X)
   \quad (\because \text{反交換子の定義}) \\
&= \alpha\beta\,XW + \beta\alpha\,WX
   \quad (\because \blkref{scalar_identity_commutes}\text{ を 2 箇所へ同時適用}) \\
&= \alpha\beta\,XW + \alpha\beta\,WX
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= \alpha\beta\left(XW + WX\right)
   \quad (\because \text{分配則による括り出し})
\end{aligned}`,
      ),
      paragraph([
        "であり、和についての加法性も行列の積の分配法則から従う。これを使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+
&= \left[c_\mu\left(-r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(-r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \blkref{def_check_fermi}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)\left(-r_\nu\right)\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ \left(-r_\mu\right)b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu\left(-r_\nu\right)\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)\left(-r_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
+ \left(-r_\mu\right)b_\nu\cdot 0 \\
&\qquad\qquad
+ b_\mu\left(-r_\nu\right)\cdot 0
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\Bigr)
   \quad (\because \blkref{anticommutator_of_check_Z_Y}\text{ を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
\left(-r_\mu\right)\left(-r_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(
r_\mu r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\right)
   \quad (\because \left(-x\right)\left(-y\right) = xy\ (\mathbb{R}\text{ の四則})) \\
&= c_\mu c_\nu\left(r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
   \quad (\because \text{分配則による } 2M_{\mathrm{col}}\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta \neq 0`),
        " なら Step 1 より ",
        math(String.raw`r_\mu r_\nu = r^2`),
        "、",
        math(String.raw`b_\mu b_\nu = -r^2`),
        " なので括弧は ",
        math(String.raw`r^2 - r^2 = 0`),
        "。いずれの場合も ",
        math(String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0`),
        "。",
      ]),
      paragraph([
        "Step 3（第 3 式）。",
        "第 1 式と同じ定義・双線型性・反交換関係を各行で適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu, \check\psi_\nu\right]_+
&= \left[c_\mu\left(r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \blkref{def_check_fermi}) \\
&= c_\mu c_\nu\Bigl(
r_\mu r_\nu\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ r_\mu b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu r_\nu\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
r_\mu r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ r_\mu b_\nu\cdot 0
+ b_\mu r_\nu\cdot 0
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\Bigr)
   \quad (\because \blkref{anticommutator_of_check_Z_Y}\text{ を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
r_\mu r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
   \quad (\because \text{分配則による } 2M_{\mathrm{col}}\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta \neq 0`),
        " なら Step 1 より括弧が ",
        math(String.raw`r^2-r^2=0`),
        "。したがって ",
        math(String.raw`\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`),
        "。",
      ]),
      paragraph([
        "Step 4（第 2 式）。定義・双線型性・反交換関係を各行で適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
&= \left[c_\mu\left(-r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \blkref{def_check_fermi}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)r_\nu\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ \left(-r_\mu\right)b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu r_\nu\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ \left(-r_\mu\right)b_\nu\cdot 0
+ b_\mu r_\nu\cdot 0
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\Bigr)
   \quad (\because \blkref{anticommutator_of_check_Z_Y}\text{ を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
\left(-r_\mu\right)r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(-r_\mu r_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I
+ b_\mu b_\nu\cdot 2M_{\mathrm{col}}\,\delta\,I\right)
   \quad (\because \left(-x\right)y=-xy\ (\mathbb{R}\text{ の四則})) \\
&= c_\mu c_\nu\left(-r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
   \quad (\because \text{分配則による } 2M_{\mathrm{col}}\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        " であり、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}I = 0`),
        " と一致する。",
        math(String.raw`\delta \neq 0`),
        "（すなわち ",
        math(String.raw`\delta = 1`),
        "）なら Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
&= \frac{-1}{4M_{\mathrm{col}}r^2}\left(-r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M_{\mathrm{col}}\,\delta\,I
   \quad (\because \text{Step 1}\ (c_\mu c_\nu = \tfrac{-1}{4M_{\mathrm{col}}r^2})) \\
&= \frac{-1}{4M_{\mathrm{col}}r^2}\left(-r^2 + \left(-r^2\right)\right)\cdot 2M_{\mathrm{col}}\,I
   \quad (\because \text{Step 1}\ (r_\mu r_\nu = r^2,\ b_\mu b_\nu = -r^2),\ \delta = 1) \\
&= \frac{-1}{4M_{\mathrm{col}}r^2}\cdot\left(-2r^2\right)\cdot 2M_{\mathrm{col}}\,I
   \quad (\because -r^2 + \left(-r^2\right) = -2r^2\text{（同類項の統合）}) \\
&= \frac{\left(-1\right)\cdot\left(-2r^2\right)\cdot 2M_{\mathrm{col}}}{4M_{\mathrm{col}}r^2}\,I
   \quad (\because \text{分数の積（}\mathbb{R}\text{ の四則）}) \\
&= \frac{4M_{\mathrm{col}}r^2}{4M_{\mathrm{col}}r^2}\,I
   \quad (\because \left(-1\right)\left(-2r^2\right) = 2r^2 \text{ と乗法の可換則}) \\
&= I
   \quad (\because M_{\mathrm{col}} \geq 2,\ r > 0 \text{ より } 4M_{\mathrm{col}}r^2 \neq 0 \text{ の約分})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}I = I`),
        " と一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の anticommutator_of_psi の半整数運動量版。008 章が Step 0（√ の分枝の一致）に費やしていた部分は、" +
          "係数が |γ_2|（非負実数）で書かれることにより絶対値の計算 1 行に置き換わった。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_02（M=2,3,4,5、μ,ν ∈ {1..M}（および負の μ）、5 組の (K1,K2)）。",
        "2026-08-19 の式変形統一で、行末根拠の機械識別子と「直前の displayMath」という指し方を人間可読な名前へ直し、" +
          "一行二等号（a_ν・b_ν の鎖と Step 4 の末尾）を一操作ずつに分け、根拠の無かった行（r_ν = r_μ、可換則、負号の移動、同類項の統合、約分）に行末根拠を補い、" +
          "散文に畳まれていた反交換子の双線型性の計算を鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_004_claim_commutation_V_plus_psi",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 6 },
    title: { tex: String.raw`V^{(+)} \text{ と } \check\psi \text{ の交換関係}` },
    labels: ["commutation_V_plus_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) = \exp(+\gamma(\tilde\theta_\mu))\,\check\psi_\mu^\dagger,
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right) = \exp(-\gamma(\tilde\theta_\mu))\,\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_T_V_plus"),
        "、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は ",
        ref("def_gamma_theta"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        " のものとする。まず、",
        math(String.raw`A_0, B_0 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`G, H \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\begin{pmatrix}A_0, & B_0\end{pmatrix}G\right)H
&= \begin{pmatrix}A_0, & B_0\end{pmatrix}\left(GH\right)
   \quad (\because \text{行列の積の結合法則})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（結合律）。実際 ",
        math(String.raw`G = \begin{pmatrix}g_{11} & g_{12} \\ g_{21} & g_{22}\end{pmatrix}`),
        "、",
        math(String.raw`H = \begin{pmatrix}h_{11} & h_{12} \\ h_{21} & h_{22}\end{pmatrix}`),
        " とすると、左辺の第 ",
        math(String.raw`l`),
        " 列は ",
        math(String.raw`\sum_{k=1}^{2} h_{kl}\left(g_{1k}A_0 + g_{2k}B_0\right)`),
        "、右辺の第 ",
        math(String.raw`l`),
        " 列は ",
        math(String.raw`\left(\sum_{k}g_{1k}h_{kl}\right)A_0 + \left(\sum_{k}g_{2k}h_{kl}\right)B_0`),
        " であり、",
        math(String.raw`\mathbb{C}`),
        " 上のスカラー倍の分配律により両者は一致する。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`T_{(V^{(+)})}`),
        " の線型性を行ベクトルへ持ち上げる）。",
        ref("V_plus_factors_invertible"),
        " と ",
        ref("T_V_plus_is_conjugation"),
        " より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        " なので、",
        ref("linearity_of_T"),
        " の一般形（",
        math(String.raw`g \in R^\times`),
        " について ",
        math(String.raw`T_g(aX+bW) = aT_g(X) + bT_g(W)`),
        "）が使える。よって ",
        math(String.raw`G \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\begin{pmatrix}A_0, & B_0\end{pmatrix}G\right)
&:= \left(T_{(V^{(+)})}\!\left(g_{11}A_0 + g_{21}B_0\right),\
T_{(V^{(+)})}\!\left(g_{12}A_0 + g_{22}B_0\right)\right)
   \quad (\because \text{行ベクトルへの作用の定め方}) \\
&= \left(g_{11}T_{(V^{(+)})}(A_0)+g_{21}T_{(V^{(+)})}(B_0),\
g_{12}T_{(V^{(+)})}(A_0)+g_{22}T_{(V^{(+)})}(B_0)\right)
   \quad (\because T_{(V^{(+)})}\text{ の線型性を 2 列へ同時適用}) \\
&= \begin{pmatrix}T_{(V^{(+)})}(A_0), & T_{(V^{(+)})}(B_0)\end{pmatrix}G
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`G`),
        " の成分は ",
        math(String.raw`A_0, B_0`),
        " に依らない複素数なので、線型性の係数として使える）。",
      ]),
      paragraph([
        "Step 2（計算）。",
        ref("def_check_fermi"),
        "、Step 1、",
        ref("T_V_plus_check_Z_Y"),
        "、",
        ref("diagonalization_check_P_D"),
        " を順に使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix}T_{(V^{(+)})}(\check\psi_\mu^\dagger), & T_{(V^{(+)})}(\check\psi_\mu)\end{pmatrix}
&= T_{(V^{(+)})}\!\left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)
   \quad (\because \check\psi_\mu,\check\psi_\mu^\dagger\text{ の定義}) \\
&= \begin{pmatrix}T_{(V^{(+)})}(\check{Z}_\mu), & T_{(V^{(+)})}(\check{Y}_\mu)\end{pmatrix}\check{P}_\mu
   \quad (\because \text{Step 1}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}A(\tilde\theta_\mu)\right)\check{P}_\mu
   \quad (\because T_{(V^{(+)})}\text{ の }\check Z,\check Y\text{ への作用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(A(\tilde\theta_\mu)\check{P}_\mu\right)
   \quad (\because \text{行ベクトルと行列の積の結合法則}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}\check{P}_\mu\right)
   \quad (\because A(\tilde\theta_\mu) = \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(\check{P}_\mu\check{D}_\mu\right)
   \quad (\because \check{P}_\mu^{-1}\check{P}_\mu = I_{\mathrm{Mat}(2,\mathbb{C})}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\check{D}_\mu
   \quad (\because \text{行ベクトルと行列の積の結合法則}) \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu
   \quad (\because \check\psi_\mu,\check\psi_\mu^\dagger\text{ の定義}) \\
&= \begin{pmatrix}\lambda_{+,\mu}\,\check\psi_\mu^\dagger, & \lambda_{-,\mu}\,\check\psi_\mu\end{pmatrix}
   \quad (\because \check D_\mu\text{ は対角成分 }\lambda_{+,\mu},\lambda_{-,\mu}\text{ の対角行列})
\end{aligned}`,
      ),
      paragraph([
        "直前の等式鎖の定義と代入は ", ref("def_check_fermi"), "、",
        ref("T_V_plus_check_Z_Y"), "、", ref("diagonalization_check_P_D"),
        " による。両辺の第 1 列・第 2 列を比べ、",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " を各列へ代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right)
&= \lambda_{+,\mu}\check\psi_\mu^\dagger
   \quad (\because \text{上の行ベクトルの等式の第 1 列}) \\
&= \exp(+\gamma(\tilde\theta_\mu))\check\psi_\mu^\dagger
   \quad (\because \lambda_{+,\mu}=\exp(+\gamma(\tilde\theta_\mu))),\\[4pt]
T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
&= \lambda_{-,\mu}\check\psi_\mu
   \quad (\because \text{上の行ベクトルの等式の第 2 列}) \\
&= \exp(-\gamma(\tilde\theta_\mu))\check\psi_\mu
   \quad (\because \lambda_{-,\mu}=\exp(-\gamma(\tilde\theta_\mu)))
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の commutation_V_psi の半整数運動量版。008 章は行ベクトル×行列の結合律を暗黙に使っていたが、" +
          "本章では行ベクトル×行列の積を def_pair_of_matrices_times_two_by_two_matrix（当時は calc_of_TxT_check_Z_Y の主張の中）の定義で入れているので、結合律を proof の冒頭で明示的に確かめた。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_03（V^{(+)} を行列指数関数から直接構成して共役を計算）。",
        "2026-08-19 の式変形統一で、行ベクトルへの線型作用の一行二等号を定義と線型性の三段へ分け、" +
          "転送行列作用の鎖の機械識別子を人間可読な根拠へ直し、末尾の二等号と固有値の指数表示への代入を各列の一続きの鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_005_definition_check_Vprime",
    kind: "definition",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 7 },
    title: { tex: String.raw`\check{V}' \text{ の定義}` },
    labels: ["def_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
      ]),
      displayMath(
        String.raw`\check{X} := \sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)
\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}),
\qquad
\check{V}' := \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "）。次が成り立つ。",
      ]),
      list([
        [
          "(1) **和の範囲に例外は要らない。** ",
          ref("def_check_index_set"),
          " (2) より ",
          math(String.raw`\mu \in \check{\mathcal{M}} \implies M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
          " なので、",
          ref("def_check_fermi"),
          " により ",
          math(String.raw`\check\psi_\mu^\dagger`),
          " と ",
          math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
          " はともに定義されており、",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          " のすべての項が意味をもつ。",
        ],
        [
          "(2) ",
          math(String.raw`\check{V}'`),
          " は可逆であり ",
          math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
          "。したがって ",
          ref("def_T_g"),
          " の ",
          math(String.raw`T_{(\check{V}')}(W) := \check{V}'\,W\,\left(\check{V}'\right)^{-1}`),
          " が定義される。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("gamma_2_theta_tilde_nonzero"),
        " はすべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " について ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " を与えるので、",
        ref("def_check_fermi"),
        " の分母 ",
        math(String.raw`2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)`),
        " は ",
        math(String.raw`0`),
        " でない。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " に対して ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので、",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " も同じ理由で定義されている。",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        " はスカラーなので各項は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元であり、有限和 ",
        math(String.raw`\check{X}`),
        " も同様である。",
      ]),
      paragraph([
        "(2) ",
        ref("matrix_exp_conjugation"),
        " (3) より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について ",
        math(String.raw`\exp(X)`),
        " は可逆で ",
        math(String.raw`\exp(X)^{-1} = \exp(-X)`),
        " である。",
        math(String.raw`X = \check{X}`),
        " とすればよい。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_Vprime の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "和の範囲が 𝓜̌ = {1,…,M} で尽きること（重複も数え落としも無いこと）は、anticommutator_of_check_psi の対 " +
          "ν = M+1−μ が 𝓜̌ 上の対合（involution）になることに対応する（def_check_index_set (2)(4)）。" +
          "数値では、この形の V̌' が T_{(V^{(+)})} と一致する（T_V_plus_eq_T_check_Vprime）ことで確認している" +
          "（sagemath/check/049_claim_even_sector_fermions/check_04, check_05）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_006_claim_action_T_check_Vprime",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 8 },
    title: { tex: String.raw`T_{(\check{V}')} \text{ の } \check\psi \text{ への作用}` },
    labels: ["action_of_T_check_Vprime_on_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) = \exp(+\gamma(\tilde\theta_\mu))\,\check\psi_\mu^\dagger,
\qquad
T_{(\check{V}')}\!\left(\check\psi_\mu\right) = \exp(-\gamma(\tilde\theta_\mu))\,\check\psi_\mu`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        "、",
        math(String.raw`\check{V}' = \exp(\check{X})`),
        "、",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        " を用いる。すなわち ",
        math(String.raw`T_{(\check{V}')}(W) = \exp(\check{X})\,W\,\exp(-\check{X})`),
        " である。",
      ]),
      paragraph([
        "Step 1（1 項ぶんの交換子、",
        math(String.raw`\check\psi_\mu^\dagger`),
        " 側）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu^\dagger\right]
= \delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger`,
      ),
      paragraph([
        "を示す。",
        ref("anticommutator_of_check_psi"),
        " を ",
        math(String.raw`(\mu, M_{\mathrm{col}}+1-\nu)`),
        " の対に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu^\dagger\right]_+
&= \left[\check\psi_\mu^\dagger,\ \check\psi_{M_{\mathrm{col}}+1-\nu}\right]_+
   \quad (\because \text{反交換子の対称性}) \\
&= \delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I
   \quad (\because \check\psi\text{ の反交換関係}) \\
&= \delta_{\mu,\,\nu}\,I
   \quad (\because M_{\mathrm{col}}+1-\nu = M_{\mathrm{col}}+1-\mu \iff \mu = \nu)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\nu \in \check{\mathcal{M}}`),
        " なので ",
        ref("anticommutator_of_check_psi"),
        " が適用できる）。また ",
        ref("anticommutator_of_check_psi"),
        " より ",
        math(String.raw`\left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+ = 0`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu^\dagger
&= \check\psi_\nu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu^\dagger\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\nu^\dagger\left(\delta_{\mu,\nu}I - \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   \quad (\because \text{直前の反交換子の等式}\ ([\check\psi_{M_{\mathrm{col}}+1-\nu}, \check\psi_\mu^\dagger]_+ = \delta_{\mu,\nu}I)) \\
&= \delta_{\mu,\nu}\,\check\psi_\nu^\dagger - \check\psi_\nu^\dagger\,\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{行列の積の分配法則と結合法則}) \\
&= \delta_{\mu,\nu}\,\check\psi_\nu^\dagger + \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_\nu^\dagger, \check\psi_\mu^\dagger]_+ = 0))
\end{aligned}`,
      ),
      paragraph(["となる。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu^\dagger\right]
&= \check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu^\dagger
   - \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{交換子の定義}) \\
&= \left(\delta_{\mu,\nu}\,\check\psi_\nu^\dagger + \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   - \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{直前の式変形}) \\
&= \delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger
   \quad (\because \text{同類項の統合})
\end{aligned}`,
      ),
      paragraph([
        "となり、上の式を得る。**",
        math(String.raw`\check{\mathcal{M}}`),
        " へ絞ったことで、合同式 ",
        math(String.raw`(1-\nu)+\mu \equiv 1 \pmod M_{\mathrm{col}}`),
        " を ",
        math(String.raw`\mu \equiv \nu`),
        " に書き換える段が要らなくなっている。**",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`[\check{X}, \check\psi_\mu^\dagger] = \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger`),
        "）。",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        " の定義を代入する。",
        math(String.raw`\tfrac12 I`),
        " は任意の元と可換（",
        ref("scalar_identity_commutes"),
        "）なので交換子に寄与せず、交換子は第 1 引数について ",
        math(String.raw`\mathbb{C}`),
        " 線型だから、Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu^\dagger\right]
&= \left[\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left(\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu} - \tfrac12 I\right),\ \check\psi_\mu^\dagger\right]
   \quad (\because \check{X}\text{ の定義}) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu} - \tfrac12 I,\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)\left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{スカラー行列は任意の元と可換なので } \left[\tfrac12 I,\ \check\psi_\mu^\dagger\right] = 0) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)\,\delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger
   \quad (\because \text{Step 1}) \\
&= \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger
   \quad (\because \mu \in \check{\mathcal{M}} \text{ なので } \nu = \mu \text{ の項だけが残る})
\end{aligned}`,
      ),
      paragraph(["である。移項すると"]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\,\check\psi_\mu^\dagger
&= \check\psi_\mu^\dagger\,\check{X} + \left[\check{X},\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{交換子の定義}) \\
&= \check\psi_\mu^\dagger\,\check{X} + \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger
   \quad (\because \text{直前の式変形}) \\
&= \check\psi_\mu^\dagger\,\check{X} + \check\psi_\mu^\dagger\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換}) \\
&= \check\psi_\mu^\dagger\left(\check{X} + \gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（帰納法）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n\,\check\psi_\mu^\dagger = \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n`),
        " が成り立つ。",
        math(String.raw`n=0`),
        " では両辺 ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " で一致し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{n+1}\check\psi_\mu^\dagger
&= \check{X}\left(\check{X}^{n}\check\psi_\mu^\dagger\right)
   \quad (\because \text{冪の定義と行列の積の結合法則}) \\
&= \check{X}\,\check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{帰納法の仮定}) \\
&= \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{Step 2}) \\
&= \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n+1}
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（指数関数へ）。Step 3 より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{n=0}^{N}\frac{\check{X}^n}{n!}\right)\check\psi_\mu^\dagger
&= \sum_{n=0}^{N}\frac{\check{X}^n\check\psi_\mu^\dagger}{n!}
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{n=0}^{N}\frac{\check\psi_\mu^\dagger
   \left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{Step 3 を各項へ同時適用}) \\
&= \check\psi_\mu^\dagger\sum_{n=0}^{N}
   \frac{\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("exp_converges"),
        " より両辺の部分和は ",
        math(String.raw`N \to \infty`),
        " で収束する。行列の積は連続（",
        ref("matrix_multiplication_continuity"),
        "）だから極限をとって",
      ]),
      displayMath(
        String.raw`\exp(\check{X})\,\check\psi_\mu^\dagger
= \check\psi_\mu^\dagger\,\exp\!\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)`,
      ),
      paragraph([
        "Step 5（結論）。準備として、",
        math(String.raw`c \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\exp(cI) = \exp(c)I
\quad (\because \left(cI\right)^n = c^n I\ (n\in\mathbb{Z}_{\geq 0})\text{ と }\exp\text{ の級数定義})`,
      ),
      paragraph([
        "である。",
        math(String.raw`\check{X}+\gamma(\tilde\theta_\mu)I`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        ref("scalar_identity_commutes"),
        " と ",
        math(String.raw`\check{X}(-\check{X}) = (-\check{X})\check{X}`),
        "）だから ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
&= \exp(\check{X})\,\check\psi_\mu^\dagger\,\exp(-\check{X})
   \quad (\because \text{証明冒頭の } T_{(\check{V}')} \text{ の表示}) \\
&= \check\psi_\mu^\dagger\,\exp\!\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)\exp(-\check{X})
   \quad (\because \text{Step 4}) \\
&= \check\psi_\mu^\dagger\,\exp\!\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{可換な指数の積の法則}) \\
&= \check\psi_\mu^\dagger\left(\exp(\gamma(\tilde\theta_\mu))I\right)
   \quad (\because \text{準備の等式 } \exp(cI)=\exp(c)I) \\
&= \exp(+\gamma(\tilde\theta_\mu))\,\check\psi_\mu^\dagger
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換})
\end{aligned}`,
      ),
      paragraph([
        "Step 1'（",
        math(String.raw`\check\psi_\mu`),
        " 側）。",
        ref("anticommutator_of_check_psi"),
        " の ",
        math(String.raw`\left[\check\psi_{M_{\mathrm{col}}+1-\nu}, \check\psi_\mu\right]_+ = 0`),
        " と ",
        math(String.raw`\left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+ = \delta_{\mu,\,M_{\mathrm{col}}+1-\nu}I`),
        " より（",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "、",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\nu \in \check{\mathcal{M}}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu
&= \check\psi_\nu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\nu^\dagger\left(-\check\psi_\mu\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_{M_{\mathrm{col}}+1-\nu}, \check\psi_\mu]_+ = 0)) \\
&= -\left(\check\psi_\nu^\dagger\,\check\psi_\mu\right)\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{行列の積の結合法則とスカラー倍}) \\
&= -\left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}I - \check\psi_\mu\,\check\psi_\nu^\dagger\right)\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_\nu^\dagger, \check\psi_\mu]_+ = \delta_{\mu,\,M_{\mathrm{col}}+1-\nu}I)) \\
&= -\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu} + \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{行列の積の分配法則と結合法則})
\end{aligned}`,
      ),
      paragraph(["となる。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu\right]
&= \check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\,\check\psi_\mu
   - \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{交換子の定義}) \\
&= \left(-\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu} + \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   - \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{直前の式変形}) \\
&= -\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{同類項の統合})
\end{aligned}`,
      ),
      paragraph([
        "Step 2'（",
        math(String.raw`[\check{X}, \check\psi_\mu] = -\gamma(\tilde\theta_\mu)\check\psi_\mu`),
        "）。Step 2 と同様に、",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        " を代入し、交換子の第 1 引数についての線型性と ",
        ref("scalar_identity_commutes"),
        "（",
        math(String.raw`\tfrac12 I`),
        " は交換子に寄与しない）を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu\right]
&= \left[\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left(\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu} - \tfrac12 I\right),\ \check\psi_\mu\right]
   \quad (\because \check{X}\text{ の定義}) \\
&= \sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu} - \tfrac12 I,\ \check\psi_\mu\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu\right]
   \quad (\because \text{スカラー行列は任意の元と可換なので } \left[\tfrac12 I,\ \check\psi_\mu\right] = 0) \\
&= -\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)\,\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{Step 1'})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " のうち ",
        math(String.raw`\delta_{\mu,\,M_{\mathrm{col}}+1-\nu} = 1`),
        " すなわち ",
        math(String.raw`M_{\mathrm{col}}+1-\nu = \mu`),
        " を満たすものは ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " ただ 1 つであり、",
        ref("def_check_index_set"),
        " (2) よりこれは ",
        math(String.raw`\check{\mathcal{M}}`),
        " に属する（**合同式を解く段が消えている**）。この ",
        math(String.raw`\nu`),
        " に対して ",
        math(String.raw`M_{\mathrm{col}}+1-\nu = \mu`),
        " なので ",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\nu} = \check\psi_\mu`),
        " である（",
        math(String.raw`\gamma`),
        " の共役添字での不変性は ",
        ref("periodicity_of_check_fermi"),
        " (3)）。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu\right]
&= -\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu})\,\check\psi_\mu
   \quad (\because \nu = M_{\mathrm{col}}+1-\mu \text{ の項だけが残り、}\check\psi_{M_{\mathrm{col}}+1-\nu} = \check\psi_\mu) \\
&= -\gamma(\tilde\theta_\mu)\,\check\psi_\mu
   \quad (\because \gamma\text{ の共役添字での不変性 (3)})
\end{aligned}`,
      ),
      paragraph(["である。移項すると"]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\,\check\psi_\mu
&= \check\psi_\mu\,\check{X} + \left[\check{X},\ \check\psi_\mu\right]
   \quad (\because \text{交換子の定義}) \\
&= \check\psi_\mu\,\check{X} - \gamma(\tilde\theta_\mu)\,\check\psi_\mu
   \quad (\because \text{直前の式変形}) \\
&= \check\psi_\mu\,\check{X} - \check\psi_\mu\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換}) \\
&= \check\psi_\mu\left(\check{X} - \gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3'（帰納法）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n\,\check\psi_\mu = \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n`),
        " が成り立つ。",
        math(String.raw`n=0`),
        " では両辺 ",
        math(String.raw`\check\psi_\mu`),
        " で一致し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{n+1}\check\psi_\mu
&= \check{X}\left(\check{X}^{n}\check\psi_\mu\right)
   \quad (\because \text{冪の定義と行列の積の結合法則}) \\
&= \check{X}\,\check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{帰納法の仮定}) \\
&= \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{Step 2'}) \\
&= \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n+1}
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4'（指数関数へ）。Step 3' より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{n=0}^{N}\frac{\check{X}^n}{n!}\right)\check\psi_\mu
&= \sum_{n=0}^{N}\frac{\check{X}^n\check\psi_\mu}{n!}
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{n=0}^{N}\frac{\check\psi_\mu
   \left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{Step 3' を各項へ同時適用}) \\
&= \check\psi_\mu\sum_{n=0}^{N}
   \frac{\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("exp_converges"),
        " より両辺の部分和は ",
        math(String.raw`N \to \infty`),
        " で収束する。行列の積は連続（",
        ref("matrix_multiplication_continuity"),
        "）だから極限をとって",
      ]),
      displayMath(
        String.raw`\exp(\check{X})\,\check\psi_\mu
= \check\psi_\mu\,\exp\!\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)`,
      ),
      paragraph([
        "Step 5'（結論）。",
        math(String.raw`\check{X}-\gamma(\tilde\theta_\mu)I`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        ref("scalar_identity_commutes"),
        " と ",
        math(String.raw`\check{X}(-\check{X}) = (-\check{X})\check{X}`),
        "）だから ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu\right)
&= \exp(\check{X})\,\check\psi_\mu\,\exp(-\check{X})
   \quad (\because \text{証明冒頭の } T_{(\check{V}')} \text{ の表示}) \\
&= \check\psi_\mu\,\exp\!\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)\exp(-\check{X})
   \quad (\because \text{Step 4'}) \\
&= \check\psi_\mu\,\exp\!\left(-\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{可換な指数の積の法則}) \\
&= \check\psi_\mu\left(\exp(-\gamma(\tilde\theta_\mu))I\right)
   \quad (\because \text{準備の等式 } \exp(cI)=\exp(c)I) \\
&= \exp(-\gamma(\tilde\theta_\mu))\,\check\psi_\mu
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の action_of_T_Vprime_on_psi の半整数運動量版。008 章にあった μ の符号による 3 通りの場合分け" +
          "（a) μ ∈ {1..M}、b) μ = -k、c) μ = -M）は、添字を μ ∈ Z で扱い periodicity_of_check_fermi を先に" +
          "用意したことで不要になった。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_04（V̌' を行列指数関数から直接構成して共役を計算）。",
        "2026-08-19 の式変形統一で、Step 1・1' の移項と交換子への回収の散文を鎖へ開き、Step 2 末尾に同居していた移項を独立の鎖へ分け、" +
          "Step 2' の一行三操作を Step 2 と同形の一操作ずつへ分け、Step 3 の一行二等号と根拠の無い行を直し、" +
          "Step 5 の exp(γI)=e^γ I の後置きの注記を準備の等式へ移し、Steps 3'〜5' の「置き換えるだけで同じ計算」を Step 3〜5 と同形の鎖へ開いた。" +
          "機械識別子の行末根拠は人間可読な名前へ直した。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_007_claim_T_eq_on_check_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 9 },
    title: {
      tex: String.raw`T_{(V^{(+)})} \text{ と } T_{(\check{V}')} \text{ は } \check{Z}, \check{Y} \text{ 上で一致する}`,
    },
    labels: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check{Z}_\mu\right) = T_{(\check{V}')}\!\left(\check{Z}_\mu\right),
\qquad
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right) = T_{(\check{V}')}\!\left(\check{Y}_\mu\right)`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " を固定する。",
        ref("V_plus_factors_invertible"),
        " と ",
        ref("T_V_plus_is_conjugation"),
        " より ",
        math(String.raw`V^{(+)} \in R^\times`),
        "、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " も可逆なので、",
        ref("mat_conj"),
        " より ",
        math(String.raw`T_{(V^{(+)})}`),
        " と ",
        math(String.raw`T_{(\check{V}')}`),
        " はともに ",
        math(String.raw`\mathbb{C}`),
        " 線型写像である。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " で書く）。",
        ref("diagonalization_check_P_D"),
        " より ",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " なので ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在する。その成分を ",
        math(String.raw`\check{P}_\mu^{-1} = \begin{pmatrix}q_{11} & q_{12} \\ q_{21} & q_{22}\end{pmatrix}`),
        "（",
        math(String.raw`q_{ij} \in \mathbb{C}`),
        "）とおくと、",
        ref("commutation_V_plus_check_psi"),
        " の proof で確かめた結合律と ",
        ref("def_check_fermi"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\check{P}_\mu\check{P}_\mu^{-1}\right)
   \quad (\because \check{P}_\mu\check{P}_\mu^{-1} = I_{\mathrm{Mat}(2,\mathbb{C})}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の結合法則}) \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{P}_\mu^{-1}
   \quad (\because \check\psi_\mu^\dagger,\check\psi_\mu\text{ の定義})
\end{aligned}`,
      ),
      paragraph(["すなわち"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_\mu
&= q_{11}\,\check\psi_\mu^\dagger + q_{21}\,\check\psi_\mu
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義}), \\
\check{Y}_\mu
&= q_{12}\,\check\psi_\mu^\dagger + q_{22}\,\check\psi_\mu
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " 上での一致）。",
        ref("commutation_V_plus_check_psi"),
        " と ",
        ref("action_of_T_check_Vprime_on_check_psi"),
        " より、いずれも ",
        math(String.raw`\exp(\pm\gamma(\tilde\theta_\mu))`),
        " 倍であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right)
&= \exp(+\gamma(\tilde\theta_\mu))\,\check\psi_\mu^\dagger
   \quad (\because V^{(+)}\text{ と }\check\psi\text{ の交換関係}) \\
&= T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
   \quad (\because T_{(\check V')}\text{ の }\check\psi\text{ への作用}), \\
T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
&= \exp(-\gamma(\tilde\theta_\mu))\,\check\psi_\mu
   \quad (\because V^{(+)}\text{ と }\check\psi\text{ の交換関係}) \\
&= T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(\check V')}\text{ の }\check\psi\text{ への作用})
\end{aligned}`,
      ),
      paragraph(["Step 3（線型性で移す）。Step 1・Step 2 と線型性より"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
&= T_{(V^{(+)})}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right)
   \quad (\because \text{Step 1}) \\
&= q_{11}T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(V^{(+)})} \text{ の線型性}) \\
&= q_{11}T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because \text{Step 2}) \\
&= T_{(\check{V}')}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right)
   \quad (\because T_{(\check{V}')} \text{ の線型性}) \\
&= T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{Step 1})
\end{aligned}`,
      ),
      paragraph([math(String.raw`\check{Y}_\mu`), " については"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right)
&= T_{(V^{(+)})}\!\left(q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu\right)
   \quad (\because \text{Step 1}) \\
&= q_{12}T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) + q_{22}T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(V^{(+)})} \text{ の線型性}) \\
&= q_{12}T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) + q_{22}T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because \text{Step 2}) \\
&= T_{(\check{V}')}\!\left(q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu\right)
   \quad (\because T_{(\check{V}')} \text{ の線型性}) \\
&= T_{(\check{V}')}\!\left(\check{Y}_\mu\right)
   \quad (\because \text{Step 1})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime_on_hatZ_hatY の半整数運動量版。008 章は γ_2(θ_μ) = 0 のとき ψ が存在しないため" +
          "「場合 2」（A(θ_μ) = I と T_Vprime_fixes_hatZ_hatY_when_gamma2_zero を経由）を必要としたが、" +
          "gamma_2_theta_tilde_nonzero によりその場合は起こらないので、008 章の「場合 1」に相当する議論だけで尽きる。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05。",
        "2026-08-19 の式変形統一で、Step 1 の行末根拠を人間可読な名前へ直し、成分表示に根拠を補い、" +
          "Step 2 の二つの一致を各作用の固有値表示を介する鎖へ開き、Step 3 の鎖の両端に根拠を補って、" +
          "Y 成分の「同じ計算」を Z 成分と同形の鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_008_claim_T_eq",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 10 },
    title: { tex: String.raw`T_{(V^{(+)})} = T_{(\check{V}')}` },
    labels: ["T_V_plus_eq_T_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（両者は単位的環準同型かつ線型）。",
        ref("V_plus_factors_invertible"),
        " と ",
        ref("T_V_plus_is_conjugation"),
        " より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        "、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " は可逆で ",
        math(String.raw`T_{(\check{V}')} = T_{\check{V}'}`),
        " である。可逆元による共役は ",
        ref("conjugation_is_ring_homomorphism"),
        " より乗法的かつ単位的（",
        math(String.raw`T_g(I) = I`),
        "）であり、",
        ref("mat_conj"),
        " より線型である。",
      ]),
      paragraph([
        "Step 2（各 ",
        math(String.raw`Z_m, Y_m`),
        " 上で一致）。",
        ref("recover_Z_Y_from_check_Z_Y"),
        " より ",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(
        String.raw`Z_m = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_\mu\,\exp(im\tilde\theta_\mu),
\qquad
Y_m = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\,\exp(im\tilde\theta_\mu)`,
      ),
      paragraph([
        "である。",
        math(String.raw`\exp(im\tilde\theta_\mu)/M_{\mathrm{col}} \in \mathbb{C}`),
        " はスカラーなので、この復元公式と、Step 1 の線型性と、",
        ref("T_V_plus_eq_T_check_Vprime_on_check_Z_Y"),
        "（以下「",
        math(String.raw`\check{Z},\check{Y}`),
        " 上の一致」と呼ぶ）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(Z_m)
&= T_{(V^{(+)})}\!\left(\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_\mu\,\exp(im\tilde\theta_\mu)\right)
   \quad (\because \text{復元公式}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \exp(im\tilde\theta_\mu)\,T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \exp(im\tilde\theta_\mu)\,T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
   \quad (\because \check{Z},\check{Y}\text{ 上の一致}) \\
&= T_{(\check{V}')}\!\left(\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_\mu\,\exp(im\tilde\theta_\mu)\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= T_{(\check{V}')}(Z_m)
   \quad (\because \text{復元公式})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_m`),
        " についても",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(Y_m)
&= T_{(V^{(+)})}\!\left(\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\,\exp(im\tilde\theta_\mu)\right)
   \quad (\because \text{復元公式}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \exp(im\tilde\theta_\mu)\,T_{(V^{(+)})}\!\left(\check{Y}_\mu\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \exp(im\tilde\theta_\mu)\,T_{(\check{V}')}\!\left(\check{Y}_\mu\right)
   \quad (\because \check{Z},\check{Y}\text{ 上の一致}) \\
&= T_{(\check{V}')}\!\left(\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\,\exp(im\tilde\theta_\mu)\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= T_{(\check{V}')}(Y_m)
   \quad (\because \text{復元公式})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`T_{(V^{(+)})}(Y_m) = T_{(\check{V}')}(Y_m)`),
        "。",
      ]),
      paragraph(["Step 3（一致する元の集合）。"]),
      displayMath(
        String.raw`\mathcal{E} := \left\{\,x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ :\
T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)\,\right\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`x, y \in \mathcal{E}`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、Step 1 の線型性から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\alpha x + \beta y)
&= \alpha T_{(V^{(+)})}(x) + \beta T_{(V^{(+)})}(y)
   \quad (\because \text{Step 1 の線型性}) \\
&= \alpha T_{(\check{V}')}(x) + \beta T_{(\check{V}')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(\check{V}')}(\alpha x + \beta y)
   \quad (\because \text{Step 1 の線型性})
\end{aligned}`,
      ),
      paragraph([
        "ゆえ ",
        math(String.raw`\alpha x + \beta y \in \mathcal{E}`),
        "。Step 1 の乗法性（",
        ref("conjugation_is_ring_homomorphism"),
        "）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(xy)
&= T_{(V^{(+)})}(x)\,T_{(V^{(+)})}(y)
   \quad (\because \text{共役は環準同型（乗法的）}) \\
&= T_{(\check{V}')}(x)\,T_{(\check{V}')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(\check{V}')}(xy)
   \quad (\because \text{共役は環準同型（乗法的）})
\end{aligned}`,
      ),
      paragraph([
        "ゆえ ",
        math(String.raw`xy \in \mathcal{E}`),
        "。また Step 1 の単位性より ",
        math(String.raw`T_{(V^{(+)})}(I) = I = T_{(\check{V}')}(I)`),
        " なので ",
        math(String.raw`I \in \mathcal{E}`),
        "。すなわち ",
        math(String.raw`\mathcal{E}`),
        " は単位元を含み、和・スカラー倍・積について閉じる。",
      ]),
      paragraph([
        "Step 4（結論）。Step 2 より ",
        math(String.raw`S := \{Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}\} \subseteq \mathcal{E}`),
        " である。",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        "（",
        math(String.raw`S`),
        " を含み和・スカラー倍・積で閉じ単位元を含む最小の部分集合）について Step 3 より ",
        math(String.raw`\mathcal{A} \subseteq \mathcal{E}`),
        " であり、",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathcal{A} \subseteq \mathcal{E} \subseteq \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\mathcal{E} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。これが statement である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime の半整数運動量版。復元公式が recover_Z_Y_from_hatZ_hatY から " +
          "recover_Z_Y_from_check_Z_Y（半整数運動量版）へ差し替わるほかは同じ議論である。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05（Z_m, Y_m だけでなく、" +
          "行列単位 e_{ij} 全体（2^M × 2^M 個）についても両者の共役が一致することを直接確認）。",
      ],
    },
  },
  {
    id: "evenfermi_009_claim_V_plus_eq_c_Vprime",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 11 },
    title: { tex: String.raw`V^{(+)} = c\,\check{V}' \text{（定数倍を除いて一致）}` },
    labels: ["V_plus_eq_c_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して",
      ]),
      displayMath(String.raw`V^{(+)} = c\,\check{V}'`),
      paragraph([
        "が成り立つ（",
        math(String.raw`V^{(+)}`),
        " は ",
        ref("def_V_plus"),
        "、",
        math(String.raw`\check{V}'`),
        " は ",
        ref("def_check_Vprime"),
        "）。**",
        math(String.raw`c`),
        " の値の決定はここでは行わない。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`W := \left(\check{V}'\right)^{-1}V^{(+)}`),
        " は可逆）。",
        ref("V_plus_factors_invertible"),
        " より ",
        math(String.raw`V^{(+)}`),
        " は可逆、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " は可逆であり、可逆行列の逆行列も可逆である（",
        ref("def_invertible_elements_of_R"),
        "）。可逆行列の積は可逆なので ",
        math(String.raw`W`),
        " は可逆であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\,W
&= \check{V}'\left(\left(\check{V}'\right)^{-1}V^{(+)}\right)
   \quad (\because W := \left(\check{V}'\right)^{-1}V^{(+)}) \\
&= \left(\check{V}'\left(\check{V}'\right)^{-1}\right)V^{(+)}
   \quad (\because \text{行列の積の結合律}) \\
&= I\,V^{(+)}
   \quad (\because \text{可逆元の定義}) \\
&= V^{(+)}
   \quad (\because \text{行列積の単位元})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`W`),
        " はすべての元と可換）。",
        ref("T_V_plus_eq_T_check_Vprime"),
        "、",
        ref("T_V_plus_is_conjugation"),
        "、",
        ref("def_check_Vprime"),
        " (2)、",
        ref("def_T_g"),
        " より、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}\,x\,\left(V^{(+)}\right)^{-1}
&= T_{(V^{(+)})}(x)
   \quad (\because \text{転送行列が定める共役作用}) \\
&= T_{(\check{V}')}(x)
   \quad (\because \text{二つの共役作用の一致}) \\
&= \check{V}'\,x\,\left(\check{V}'\right)^{-1}
   \quad (\because \text{転送行列が定める共役作用})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("conjugation_is_ring_homomorphism"),
        " の ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " より Step 1 の ",
        math(String.raw`V^{(+)} = \check{V}'W`),
        " から ",
        math(String.raw`\left(V^{(+)}\right)^{-1} = W^{-1}\left(\check{V}'\right)^{-1}`),
        " である。したがって、左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}x\left(V^{(+)}\right)^{-1}
&= \left(\check{V}'W\right)x\left(W^{-1}\left(\check{V}'\right)^{-1}\right)
   \quad (\because \text{Step 1 と積の逆元の公式}) \\
&= \check{V}'\left(W x W^{-1}\right)\left(\check{V}'\right)^{-1}
   \quad (\because \text{行列の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "と書ける。したがって ",
        math(String.raw`\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1} = \check{V}'x\left(\check{V}'\right)^{-1}`),
        " である。可逆な ",
        math(String.raw`\check V'`),
        " と ",
        math(String.raw`W`),
        " を順に消去すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1}
&= \check{V}'x\left(\check{V}'\right)^{-1}
   \quad (\because \text{上の二つの共役作用の一致}) \\
WxW^{-1}
&= x
   \quad (\because \check V' \text{ の可逆性}) \\
Wx
&= xW
   \quad (\because W \text{ の可逆性})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（スカラーであること）。Step 2 と ",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\,I`),
        "。",
      ]),
      paragraph([
        "Step 4（",
        math(String.raw`c \neq 0`),
        "）。仮に ",
        math(String.raw`c = 0`),
        " なら ",
        math(String.raw`W = O`),
        "（零行列）だが、任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`OA = O \neq I`),
        " なので ",
        math(String.raw`O`),
        " は可逆でなく、Step 1 に矛盾する。よって ",
        math(String.raw`c \in \mathbb{C}^\times`),
        "。",
      ]),
      paragraph([
        "Step 5（結論）。Step 1 と Step 3、およびスカラー行列との積の可換性（",
        ref("scalar_identity_commutes"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= \check{V}'W
   \quad (\because \text{Step 1}) \\
&= \check{V}'\left(c\,I\right)
   \quad (\because \text{Step 3}) \\
&= c\left(\check{V}'I\right)
   \quad (\because \text{スカラー行列との積の可換性}) \\
&= c\,\check{V}'
   \quad (\because \text{行列積の単位元 } \check{V}'I = \check{V}')
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の V_eq_Vprime の半整数運動量版。008 章と同じく centralizer_is_scalar を用いる筋であり、" +
          "クリフォード群（def_clifford_group / V2_not_in_clifford_group）には依存しない。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_06（W = (V̌')^{-1} V^{(+)} がスカラー行列に" +
          "なることを確認し、その c が (2 sinh 2K_2)^{M/2} に一致することも併せて確認した。" +
          "ただし c の値そのものの証明は本章では行わない）。",
      ],
    },
  },
  {
    id: "evenEigen_001_definition_check_number_operator",
    kind: "definition",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 3 },
    title: { tex: String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} \text{ の定義}` },
    labels: ["def_check_number_operator"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので、",
        ref("def_check_fermi"),
        " により ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " は**ともに定義されている**。そこで",
      ]),
      displayMath(
        String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})
\qquad (\mu \in \check{\mathcal{M}})`,
      ),
      paragraph([
        "と定める。以下、",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " を単に ",
        math(String.raw`I`),
        " と書く。次が成り立つ。",
      ]),
      list([
        [
          "(1) 共役添字の対応 ",
          math(String.raw`\mu \mapsto M_{\mathrm{col}}+1-\mu`),
          " は ",
          math(String.raw`\check{\mathcal{M}}`),
          " 上の対合である：",
          math(String.raw`M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu) = \mu`),
          "。したがって ",
          math(String.raw`\check{n}_\mu`),
          " は ",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          " の ",
          math(String.raw`M_{\mathrm{col}}`),
          " 個で尽き、",
          math(String.raw`\check{\mathcal{M}}`),
          " の外の添字は要らない。",
        ],
        [
          "(2) ",
          ref("def_check_Vprime"),
          " の ",
          math(String.raw`\check{X}`),
          " と ",
          math(String.raw`\check{V}'`),
          " はこの記号で",
        ],
      ]),
      displayMath(
        String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)
\left(\check{n}_\mu - \tfrac12 I\right),
\qquad
\check{V}' = \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と書ける。",
        "**",
        math(String.raw`\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " を例外なく走る**（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu) = \mu`),
        " は展開するだけである。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\mu \mapsto M_{\mathrm{col}}+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " から ",
        math(String.raw`\check{\mathcal{M}}`),
        " への写像であり、いま示したとおり 2 回施すと恒等写像になるので全単射（対合）である。",
        "したがって ",
        math(String.raw`\check{n}_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）を作るのに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字は現れない。",
      ]),
      paragraph([
        "(2) ",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)`),
        " の各項の第 1 因子が定義により ",
        math(String.raw`\check{n}_\mu`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の def_number_operator の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01。対を −μ に取り違えると冪等性が残差 2.59 で破れることも対照として確認した。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "diagonalization_and_exponential_form_claim_V_plus_eq_c_exp_check_number_operators",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)` },
    labels: ["V_plus_eq_c_exp_sum_gamma_check_number_operator"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_arccosh"),
        " が逆双曲線余弦を実対数で定めるため）、",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "、",
        ref("def_check_index_set"),
        "）と ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " について、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して",
      ]),
      displayMath(
        String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`c`),
        " の値の決定はここでは行わない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("V_plus_eq_c_check_Vprime"),
        " により、",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " を満たす ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " を取る（",
        math(String.raw`\check{V}'`),
        " は ",
        ref("def_check_Vprime"),
        "）。この ",
        math(String.raw`c`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= c\,\check{V}'
&&(\because\ \blkref{V_plus_eq_c_check_Vprime}) \\
&= c\,\exp\!\left(\check{X}\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{V}' := \exp(\check{X})) \\
&= c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{X}\ \text{の定義}) \\
&= c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_number_operator}\ \text{の}\ \check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、A(θ̃_μ) の対角化と V^{(+)} の指数表示の章のゴールの式を一つの主張として立てた。既存の主張 V_plus_eq_c_check_Vprime に、V̌'・X̌・ň_μ の定義を順に代入するだけで、新しい証明は無い。",
      ],
    },
  },
  {
    id: "diagonalization_and_exponential_form_claim_A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化、}\lambda_{\pm,\mu} = \exp(\pm\gamma(\tilde\theta_\mu))\text{ と }V^{(+)}\text{ の指数表示}` },
    labels: ["A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta) \in \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`\theta \in \mathbb{R}`),
        "）、",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{\pm,\mu} \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("eigenvector_of_A_theta_tilde"),
        " が ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " を実数の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)`),
        " と絶対値 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " の和・差で与えるため）、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\theta) \in \mathbb{R}_{\geq 0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_arccosh"),
        " が逆双曲線余弦を実対数で定めるため）、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_second_dual_coupling_constant"),
        " が ",
        math(String.raw`K_2^*`),
        " を実対数で定めるため）、",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        "、",
        ref("def_check_fermi"),
        " の ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        "、",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu`),
        "、",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)}`),
        "（",
        math(String.raw`\check{Z}_\mu`),
        " 以下はいずれも ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元）と ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " について、次の五つが成り立つ。(1)(2)(4) は任意の ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について、(3) は任意の ",
        math(String.raw`\theta \in \mathbb{R}`),
        " について述べる。(4) は二つの定義の再掲である。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad A(\tilde\theta_\mu) = \check{P}_\mu \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix} \check{P}_\mu^{-1}`),
          "（",
          math(String.raw`\check{P}_\mu`),
          " は可逆）",
        ],
        [math(String.raw`\text{(2)}\quad \lambda_{\pm,\mu} = \exp\left(\pm\gamma(\tilde\theta_\mu)\right)`)],
        [
          math(String.raw`\text{(3)}\quad \gamma(\theta) = \mathrm{arccosh}\left(\cosh 2K_1 \cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^* \cos\theta\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix} = \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu,\qquad \check{n}_\mu = \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(5)}\quad`),
          " ある ",
          math(String.raw`c \in \mathbb{C}^\times`),
          " が存在して ",
          math(String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)`),
        ],
      ]),
      paragraph([
        math(String.raw`c`),
        " の値の決定はここでは行わない。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("diagonalization_check_P_D"),
        " により ",
        math(String.raw`\det\check{P}_\mu \neq 0_{\mathbb{C}}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)
&= \check{P}_\mu\,\check{D}_\mu\,\check{P}_\mu^{-1}
&&(\because\ \blkref{diagonalization_check_P_D}) \\
&= \check{P}_\mu \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix} \check{P}_\mu^{-1}
&&(\because\ \blkref{diagonalization_check_P_D}\ \text{の}\ \check{D}_\mu\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{+,\mu} = \exp(+\gamma(\tilde\theta_\mu))`),
        " と ",
        math(String.raw`\lambda_{-,\mu} = \exp(-\gamma(\tilde\theta_\mu))`),
        " そのものである。",
      ]),
      paragraph(["(3) ", math(String.raw`\theta \in \mathbb{R}`), " について"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma(\theta)
&= \mathrm{arccosh}\left(\gamma_1(\theta)\right)
&&(\because\ \blkref{def_gamma_theta}) \\
&= \mathrm{arccosh}\left(c_1 c_2^* - s_1 s_2^* \cos\theta\right)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{の}\ \gamma_1(\theta)\ \text{の定義}) \\
&= \mathrm{arccosh}\left(\cosh 2K_1 \cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^* \cos\theta\right)
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\ \text{の}\ c_i, s_i, c_i^*, s_i^*\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "(4) 一つ目の式は ",
        ref("def_check_fermi"),
        " の ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " の定義、二つ目の式は ",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu`),
        " の定義そのものである。",
      ]),
      paragraph([
        "(5) ",
        ref("V_plus_eq_c_exp_sum_gamma_check_number_operator"),
        " そのものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、章立て案のこの章のゴールの式（A(θ̃_μ) の対角化、λ_{±,μ} = exp(±γ(θ̃_μ))、γ(θ) の明示形、ψ̌_μ と ň_μ の定義、V^{(+)} の指数表示）を一つの主張として立てた。既存の主張と定義を挙げるだけで、新しい証明は無い。",
      ],
    },
  },
]);
