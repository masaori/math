import { defineBlocks, displayMath, list, math, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "isomorphism_heading",
    kind: "heading",
    level: 1,
    title: { text: "同型の証明" },
    labels: [],
  },
  {
    id: "isomorphism_definition_count_of_subset_elements_below_index",
    kind: "definition",
    title: { text: "部分集合のうち番号より小さい元を数える個数" },
    labels: ["def_count_of_subset_elements_below_index"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、整数 ",
        math(String.raw`N_i(T)\in\mathbb{Z}_{\ge 0}`),
        " を、",
        math(String.raw`i`),
        " についての帰納法で次のように定める。",
      ]),
      list([
        [
          math(String.raw`i=1`),
          " のとき、",
          math(String.raw`N_1(T):=0`),
          " とする。",
        ],
        [
          math(String.raw`i\in\{2,\dots,M\}`),
          " のとき、",
          math(String.raw`i-1\in T`),
          " なら ",
          math(String.raw`N_i(T):=N_{i-1}(T)+1`),
          "、",
          math(String.raw`i-1\notin T`),
          " なら ",
          math(String.raw`N_i(T):=N_{i-1}(T)`),
          " とする。",
        ],
      ]),
      paragraph([
        "この式が各 ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " に ",
        math(String.raw`\mathbb{Z}_{\ge 0}`),
        " の元を一つずつ定めることを、",
        math(String.raw`i`),
        " についての帰納法で確かめる。",
        math(String.raw`i=1`),
        " のとき、",
        math(String.raw`0\in\mathbb{Z}_{\ge 0}`),
        " である。",
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`N_{i-1}(T)\in\mathbb{Z}_{\ge 0}`),
        " が一つに定まっているとする。",
        math(String.raw`i-1\in\{1,\dots,M\}`),
        " なので、",
        math(String.raw`\mathcal{P}_M`),
        " の定義（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）により ",
        math(String.raw`i-1\in T`),
        " か ",
        math(String.raw`i-1\notin T`),
        " のどちらか一方だけが成り立ち、",
        math(String.raw`N_i(T)`),
        " は一つに決まる。",
        math(String.raw`N_{i-1}(T)+1`),
        " と ",
        math(String.raw`N_{i-1}(T)`),
        " はどちらも ",
        math(String.raw`\mathbb{Z}_{\ge 0}`),
        " の元である（",
        math(String.raw`+`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の加法）。",
      ]),
      paragraph([
        math(String.raw`N_i(T)`),
        " は、",
        math(String.raw`t=1,\dots,i-1`),
        " の順に ",
        math(String.raw`t\in T`),
        " であるたびに 1 を足した値である。記号 ",
        math(String.raw`N_i(T)`),
        " は ",
        math(String.raw`M`),
        " を書かないが、",
        math(String.raw`M`),
        " を固定して定める。",
        math(String.raw`N_i(T)`),
        " は生成作用素の行列の成分の符号に使う。",
      ]),
      paragraph([
        "この定義は、有限集合の元の個数と、",
        math(String.raw`T`),
        " の元を小さい順に並べる写像を使わない。",
        math(String.raw`N_i(T)`),
        " が集合 ",
        math(String.raw`\{t\in T : t<i\}`),
        " の元の個数に等しいことは、元の個数を定めないので主張しない。",
        math(String.raw`T`),
        " に一つの元を足したときの ",
        math(String.raw`N_i`),
        " の値は、後の主張で示す。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_sign_of_nonnegative_integer",
    kind: "definition",
    title: { text: "非負整数の偶奇による符号" },
    labels: ["def_sign_of_nonnegative_integer"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\varsigma(n)\in\mathbb{C}`),
        " を、",
        math(String.raw`n`),
        " についての帰納法で次のように定める。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元（",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元）である。",
      ]),
      list([
        [
          math(String.raw`n=0`),
          " のとき、",
          math(String.raw`\varsigma(0):=1_{\mathbb{C}}`),
          " とする。",
        ],
        [
          math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
          " のとき、",
          math(String.raw`\varsigma(n):=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)`),
          " とする。",
        ],
      ]),
      paragraph([
        "この式が各 ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元を一つずつ定めることを、",
        math(String.raw`n`),
        " についての帰納法で確かめる。",
        math(String.raw`n=0`),
        " のとき、",
        math(String.raw`1_{\mathbb{C}}\in\mathbb{C}`),
        " である。",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`n-1\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\varsigma(n-1)\in\mathbb{C}`),
        " が一つに定まっているとする。",
        math(String.raw`-1_{\mathbb{C}}\in\mathbb{C}`),
        " なので、",
        math(String.raw`\mathbb{C}`),
        " の乗法の値 ",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        math(String.raw`\varsigma(n)`),
        " は、生成作用素の行列の成分の符号 ",
        math(String.raw`(-1)^{N_i(T)}`),
        " を ",
        math(String.raw`\varsigma(N_i(T))`),
        "（",
        ref("def_count_of_subset_elements_below_index"),
        "）と書くために置く。",
        math(String.raw`\mathbb{C}`),
        " の元の冪の一般の定義と指数法則は使わないので置かない。",
        math(String.raw`\varsigma(n)`),
        " の値が ",
        math(String.raw`1_{\mathbb{C}}`),
        " か ",
        math(String.raw`-1_{\mathbb{C}}`),
        " であることと、",
        math(String.raw`\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)=1_{\mathbb{C}}`),
        " であることは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_creation_operator_matrix",
    kind: "definition",
    title: { text: "生成作用素の行列" },
    labels: ["def_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`\mathcal{P}_M`),
        " を ",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合全体の集合（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`\mathcal{P}_M`),
        " は有限集合である（",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）ので、",
        math(String.raw`\mathcal{P}_M`),
        " で添字づけた行列の集合 ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）が定まる。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ",
        math(String.raw`c_i`),
        " を、",
        math(String.raw`S,T\in\mathcal{P}_M`),
        " についての成分で次のように定め、生成作用素の行列と呼ぶ。",
      ]),
      displayMath(String.raw`(c_i)_{S,T}:=
\begin{cases}
  \varsigma(N_i(T)) & (i\notin T\ \text{かつ}\ S=T\cup\{i\}),\\
  0_{\mathbb{C}} & (\text{それ以外}).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_i(T)\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " かつ ",
        math(String.raw`T\in\mathcal{P}_M`),
        " なので定まる）であり、",
        math(String.raw`\varsigma(N_i(T))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。",
        math(String.raw`T\cup\{i\}`),
        " は ",
        math(String.raw`T\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合なので、",
        math(String.raw`\mathcal{P}_M`),
        " の元である。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " について、条件「",
        math(String.raw`i\notin T`),
        " かつ ",
        math(String.raw`S=T\cup\{i\}`),
        "」は成り立つか成り立たないかのどちらか一方だけである（",
        math(String.raw`i\notin T`),
        " は ",
        ref("def_power_set_of_first_m_positive_integers"),
        " により真偽が一つに決まり、",
        math(String.raw`S=T\cup\{i\}`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の元の等しさとして真偽が一つに決まる）。どちらの場合も右辺は ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって ",
        math(String.raw`c_i`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`c_i`),
        " は ",
        math(String.raw`M`),
        " を書かないが、",
        math(String.raw`M`),
        " を固定して定める。下付きの添字 ",
        math(String.raw`i`),
        " は行列を選ぶ添字であり、成分の添字 ",
        math(String.raw`(S,T)`),
        " とは別である。",
        math(String.raw`c_i`),
        " の成分が ",
        math(String.raw`0_{\mathbb{C}}`),
        " 以外の式で定まるのは、列の添字 ",
        math(String.raw`T`),
        " が ",
        math(String.raw`i`),
        " を含まないときの、行の添字 ",
        math(String.raw`T\cup\{i\}`),
        " の位置だけにある。",
        math(String.raw`T\cup\{i\}`),
        " は二つの集合の和集合であり、",
        math(String.raw`\mathcal{P}_M`),
        " の上の演算としては定めない。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_annihilation_operator_matrix",
    kind: "definition",
    title: { text: "消滅作用素の行列" },
    labels: ["def_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ",
        math(String.raw`c_i^{\mathsf T}`),
        " を、",
        math(String.raw`S,T\in\mathcal{P}_M`),
        " についての成分で次のように定め、消滅作用素の行列と呼ぶ。",
      ]),
      displayMath(String.raw`(c_i^{\mathsf T})_{S,T}:=(c_i)_{T,S}.`),
      paragraph([
        "各 ",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " について ",
        math(String.raw`(T,S)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " であり、",
        math(String.raw`c_i`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）ので、右辺 ",
        math(String.raw`(c_i)_{T,S}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって ",
        math(String.raw`c_i^{\mathsf T}`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`c_i^{\mathsf T}`),
        " は一つの記号であり、",
        math(String.raw`c_i`),
        " ごとにこの式で直接定める。上付きの ",
        math(String.raw`\mathsf T`),
        " は成分の添字 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " とは別のものである。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の一般の元の転置は定義せず、転置の性質も使わない。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_count_below_index_after_adding_one_element",
    kind: "claim",
    title: { text: "部分集合に一つの元を足したときの、番号より小さい元を数える個数の値" },
    labels: ["claim_count_below_index_after_adding_one_element"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`j\notin T`),
        " とする。このとき ",
        math(String.raw`T\cup\{j\}\in\mathcal{P}_M`),
        " であり、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）は次を満たす（",
        math(String.raw`+`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の加法）。",
      ]),
      displayMath(String.raw`N_i(T\cup\{j\})=
\begin{cases}
  N_i(T)+1 & (j<i),\\
  N_i(T) & (j\ge i).
\end{cases}`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`T\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`T\cup\{j\}\subseteq\{1,\dots,M\}`),
        " なので、",
        math(String.raw`T\cup\{j\}\in\mathcal{P}_M`),
        " であり、",
        math(String.raw`N_i(T\cup\{j\})`),
        " が定まる（",
        ref("def_count_of_subset_elements_below_index"),
        "）。和集合と ",
        math(String.raw`\{j\}`),
        " の定義により、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`t\neq j`),
        " なら ",
        math(String.raw`t\in T\cup\{j\}`),
        " と ",
        math(String.raw`t\in T`),
        " は同値であり（",
        math(String.raw`\star`),
        "）、",
        math(String.raw`j\in T\cup\{j\}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`T`),
        " と ",
        math(String.raw`j`),
        " を固定し、",
        math(String.raw`i`),
        " についての帰納法で示す。",
        math(String.raw`i=1`),
        " のとき。",
        math(String.raw`j\in\{1,\dots,M\}`),
        " なので ",
        math(String.raw`j\ge 1=i`),
        " であり、示す等式は ",
        math(String.raw`N_1(T\cup\{j\})=N_1(T)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_1(T\cup\{j\})
&=0
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_1(T)
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`i-1`),
        " について主張が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`j`),
        " と ",
        math(String.raw`i-1`),
        " の大小で三つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`j<i-1`),
          " のとき。",
          math(String.raw`j<i`),
          " なので、示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)+1`),
          " である。帰納法の仮定（",
          math(String.raw`j<i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)+1`),
          " である。",
          math(String.raw`i-1\neq j`),
          " なので、（",
          math(String.raw`\star`),
          "）から ",
          math(String.raw`i-1\in T\cup\{j\}`),
          " と ",
          math(String.raw`i-1\in T`),
          " は同値である。",
          math(String.raw`i-1\in T`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\bigl(N_{i-1}(T)+1\bigr)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\in T\ \text{なので}\ N_i(T)=N_{i-1}(T)+1\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i-1\notin T`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})
&&\left(\because\ i-1\notin T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i(T)=N_{i-1}(T)\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j=i-1`),
          " のとき。",
          math(String.raw`j<i`),
          " なので、示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)+1`),
          " である。",
          math(String.raw`j\ge i-1`),
          " なので、帰納法の仮定（",
          math(String.raw`j\ge i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)`),
          " である。",
          math(String.raw`i-1=j\in T\cup\{j\}`),
          " であり、",
          math(String.raw`i-1=j\notin T`),
          " である。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i(T)=N_{i-1}(T)\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j\ge i`),
          " のとき。示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)`),
          " である。",
          math(String.raw`j\ge i>i-1`),
          " なので、帰納法の仮定（",
          math(String.raw`j\ge i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)`),
          " である。",
          math(String.raw`i-1\neq j`),
          " なので、（",
          math(String.raw`\star`),
          "）から ",
          math(String.raw`i-1\in T\cup\{j\}`),
          " と ",
          math(String.raw`i-1\in T`),
          " は同値である。",
          math(String.raw`i-1\in T`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)
&&\left(\because\ i-1\in T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i-1\notin T`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})
&&\left(\because\ i-1\notin T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        "三つの場合は ",
        math(String.raw`j<i-1`),
        "、",
        math(String.raw`j=i-1`),
        "、",
        math(String.raw`j>i-1`),
        "（整数なので ",
        math(String.raw`j\ge i`),
        " と同じ）を尽くすので、",
        math(String.raw`i`),
        " について主張が成り立つ。以上で、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_entry_of_matrix_times_creation_operator_matrix",
    kind: "claim",
    title: { text: "右から生成作用素の行列を掛けた行列の成分" },
    labels: ["claim_entry_of_matrix_times_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_j\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`A\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）の成分は次のとおりである。",
      ]),
      displayMath(String.raw`\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}=
\begin{cases}
  A_{S,U\cup\{j\}}\cdot_{\mathbb{C}}\varsigma(N_j(U)) & (j\notin U),\\
  0_{\mathbb{C}} & (j\in U).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_j(U)\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）、",
        math(String.raw`\varsigma(N_j(U))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。",
        math(String.raw`U\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`U\cup\{j\}\in\mathcal{P}_M`),
        " なので、",
        math(String.raw`A_{S,U\cup\{j\}}\in\mathbb{C}`),
        " が定まる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        math(String.raw`j\in U`),
        " か ",
        math(String.raw`j\notin U`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`j\in U`),
          " のとき。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について次の等式を示す。",
          math(String.raw`j\in U`),
          " なので、",
          math(String.raw`c_j`),
          " の定義の条件「",
          math(String.raw`j\notin U`),
          " かつ ",
          math(String.raw`T=U\cup\{j\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&=A_{S,T}\cdot_{\mathbb{C}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=A_{S,T}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\text{（二回）}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \text{各}\ T\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}\right)
&&\left(\because\ \rho:=0_{\mathbb{C}}\text{、}\lambda_T:=1_{\mathbb{C}}\text{、}v_T:=1_{\mathbb{C}}\ \text{を当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ \text{零のスカラー倍は零ベクトル。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j\notin U`),
          " のとき。",
          math(String.raw`R:=U\cup\{j\}\in\mathcal{P}_M`),
          " と置く。",
          math(String.raw`j\notin U`),
          " なので、",
          math(String.raw`T\in\mathcal{P}_M`),
          " について ",
          math(String.raw`c_j`),
          " の定義の条件「",
          math(String.raw`j\notin U`),
          " かつ ",
          math(String.raw`T=U\cup\{j\}`),
          "」は ",
          math(String.raw`T=R`),
          " と同値である。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について ",
          math(String.raw`(c_j)_{T,U}=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))`),
          " を示す。",
          math(String.raw`\delta_{R,T}\in\mathbb{C}`),
          " は ",
          math(String.raw`\mathcal{P}_M`),
          " の二元についてのクロネッカーのデルタ（",
          ref("def_kronecker_delta"),
          "）である。",
          math(String.raw`T=R`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(c_j)_{T,U}
&=\varsigma(N_j(U))
&&\left(\because\ T=R\ \text{なので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq R`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_j)_{T,U}
&=0_{\mathbb{C}}
&&\left(\because\ T\neq R\ \text{なので条件が成り立たず、}c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "さらに、",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=A_{S,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項のデルタを係数の位置へ移した次の等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&=A_{S,T}\cdot_{\mathbb{C}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=A_{S,T}\cdot_{\mathbb{C}}\bigl(\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \text{上の準備の等式}\right)\\
&=(A_{S,T}\cdot_{\mathbb{C}}\delta_{R,T})\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(\delta_{R,T}\cdot_{\mathbb{C}}A_{S,T})\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\bigl(A_{S,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{R,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_R
&&\left(\because\ \text{主張の}\ x\ \text{に}\ R\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=A_{S,R}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ r_T\ \text{の置き方で}\ T:=R\right)\\
&=A_{S,U\cup\{j\}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ",
        math(String.raw`j\in U`),
        " と ",
        math(String.raw`j\notin U`),
        " を尽くすので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_creation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "生成作用素の行列どうしの反交換関係" },
    labels: ["claim_creation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i,c_j\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`i=j`),
        " の場合も含めて、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i
=0_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`k,l\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、条件 ",
        math(String.raw`\mathrm{C}_{k,l}(S,U)`),
        " を「",
        math(String.raw`k\notin U`),
        " かつ ",
        math(String.raw`l\notin U`),
        " かつ ",
        math(String.raw`k\neq l`),
        " かつ ",
        math(String.raw`S=(U\cup\{l\})\cup\{k\}`),
        "」と置く。各 ",
        math(String.raw`k,l,S,U`),
        " について、次の等式（",
        math(String.raw`\star`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}=
\begin{cases}
  \varsigma\bigl(N_k(U\cup\{l\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_l(U)) & (\mathrm{C}_{k,l}(S,U)\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star)`),
      list([
        [
          math(String.raw`l\in U`),
          " のとき。",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " は成り立たず、右から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_matrix_times_creation_operator_matrix"),
          "）を ",
          math(String.raw`A:=c_k`),
          "、主張の ",
          math(String.raw`j`),
          " に ",
          math(String.raw`l`),
          " を当てると、",
          math(String.raw`(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l)_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`l\notin U`),
          " のとき。",
          math(String.raw`U\cup\{l\}\in\mathcal{P}_M`),
          " である。和集合の定義により、",
          math(String.raw`k\notin U\cup\{l\}`),
          " は「",
          math(String.raw`k\notin U`),
          " かつ ",
          math(String.raw`k\neq l`),
          "」と同値である。したがって、",
          math(String.raw`c_k`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で列の添字を ",
          math(String.raw`U\cup\{l\}`),
          " としたときの条件「",
          math(String.raw`k\notin U\cup\{l\}`),
          " かつ ",
          math(String.raw`S=(U\cup\{l\})\cup\{k\}`),
          "」は、",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " と同値である。",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}
&=(c_k)_{S,U\cup\{l\}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ A:=c_k\text{、主張の}\ j\ \text{に}\ l\ \text{を当て、}l\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\varsigma\bigl(N_k(U\cup\{l\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ \text{条件が成り立つので}\ c_k\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_{k,l}(S,U)`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}
&=(c_k)_{S,U\cup\{l\}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ A:=c_k\text{、主張の}\ j\ \text{に}\ l\ \text{を当て、}l\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_k\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "以上で（",
        math(String.raw`\star`),
        "）が示された。次に、",
        math(String.raw`\mathrm{C}_{i,j}(S,U)`),
        " と ",
        math(String.raw`\mathrm{C}_{j,i}(S,U)`),
        " は同値である。実際、",
        math(String.raw`i\neq j`),
        " と ",
        math(String.raw`j\neq i`),
        " は同値であり、和集合の定義により、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in(U\cup\{j\})\cup\{i\}`),
        " と ",
        math(String.raw`t\in(U\cup\{i\})\cup\{j\}`),
        " はどちらも「",
        math(String.raw`t\in U`),
        " または ",
        math(String.raw`t=i`),
        " または ",
        math(String.raw`t=j`),
        "」と同値なので、",
        math(String.raw`(U\cup\{j\})\cup\{i\}=(U\cup\{i\})\cup\{j\}`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        " の元の等しさ）。",
      ]),
      paragraph([
        "本題。行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
        math(String.raw`\mathrm{C}_{i,j}(S,U)`),
        " が成り立つか否かで場合を分ける（上で示した同値により、",
        math(String.raw`\mathrm{C}_{j,i}(S,U)`),
        " も同じ真偽をとる）。",
      ]),
      list([
        [
          math(String.raw`\mathrm{C}_{i,j}(S,U)`),
          " が成り立たないとき。",
          math(String.raw`\mathrm{C}_{j,i}(S,U)`),
          " も成り立たない。",
          math(String.raw`i=j`),
          " の場合はつねにこちらに入る（",
          math(String.raw`i\neq j`),
          " が成り立たないため）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立たない}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`\mathrm{C}_{i,j}(S,U)`),
          " が成り立つとき。",
          math(String.raw`\mathrm{C}_{j,i}(S,U)`),
          " も成り立ち、",
          math(String.raw`i\notin U`),
          "、",
          math(String.raw`j\notin U`),
          "、",
          math(String.raw`i\neq j`),
          " である。",
          math(String.raw`i,j`),
          " は整数なので、",
          math(String.raw`j<i`),
          " か ",
          math(String.raw`i<j`),
          " のどちらか一方である。どちらの場合も、部分集合に一つの元を足したときの個数の値の主張（",
          ref("claim_count_below_index_after_adding_one_element"),
          "）を ",
          math(String.raw`T:=U`),
          " に当てる。",
          math(String.raw`j<i`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma\bigl(N_i(U\cup\{j\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立つ}\right)\\
&\quad=\varsigma\bigl(N_i(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j<i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma\bigl(N_i(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i\ge j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_i(U))\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ n:=N_i(U)+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_i(U)\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i<j`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma\bigl(N_i(U\cup\{j\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立つ}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j\ge i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i<j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ n:=N_j(U)+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_j(U)\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "場合分けはすべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "消滅作用素の行列どうしの反交換関係" },
    labels: ["claim_annihilation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i^{\mathsf T},c_j^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とする。",
        math(String.raw`i=j`),
        " の場合も含めて、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}
=0_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "準備。和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。",
        math(String.raw`k,l\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、次の等式（",
        math(String.raw`\star`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_k^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l^{\mathsf T}\bigr)_{S,U}
=\bigl(c_l\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\bigr)_{U,S}.
\qquad(\star)`),
      paragraph([
        "まず、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について和の項を書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_l^{\mathsf T})_{T,U}
&=(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}}(c_l^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(c_k)_{T,S}\cdot_{\mathbb{C}}(c_l)_{U,T}
&&\left(\because\ c_k^{\mathsf T}\ \text{と}\ c_l^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=(c_l)_{U,T}\cdot_{\mathbb{C}}(c_k)_{T,S}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(c_l)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_k)_{T,S}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って（",
        math(String.raw`\star`),
        "）の左辺を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l^{\mathsf T}\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_l^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(c_l)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_k)_{T,S}
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(c_l\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\bigr)_{U,S}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "本題。行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}\\
&\quad=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}+_{\mathbb{C}}\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{U,S}
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\right)\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{U,S}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{U,S}
&&\left(\because\ \text{生成作用素の行列どうしの反交換関係。}\blkref{claim_creation_operator_matrices_anticommute}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S,U\in\mathcal{P}_M`),
        " は任意なので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_sign_of_nonnegative_integer_squares_to_one",
    kind: "claim",
    title: { text: "非負整数の偶奇による符号の自分自身との積は 1 であること" },
    labels: ["claim_sign_of_nonnegative_integer_squares_to_one"],
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について、非負整数の偶奇による符号 ",
        math(String.raw`\varsigma(n)\in\mathbb{C}`),
        "（",
        ref("def_sign_of_nonnegative_integer"),
        "）は ",
        math(String.raw`\mathbb{C}`),
        " の中で次を満たす。",
      ]),
      displayMath(String.raw`\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)=1_{\mathbb{C}}.`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元である（",
        ref("def_sign_of_nonnegative_integer"),
        "）。まず ",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "これを使って、",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \text{上の等式}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "本題。",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varsigma(0)\cdot_{\mathbb{C}}\varsigma(0)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \varsigma(0)\ \text{の定義を二つの因子に。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`n-1\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)=1_{\mathbb{C}}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ n\in\mathbb{Z}_{\ge 1}\ \text{での}\ \varsigma(n)\ \text{の定義を二つの因子に。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\varsigma(n-1)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\cdot_{\mathbb{C}}\varsigma(n-1)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ \text{準備の}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph([
        "帰納法により、すべての ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_entry_of_creation_operator_matrix_times_matrix",
    kind: "claim",
    title: { text: "左から生成作用素の行列を掛けた行列の成分" },
    labels: ["claim_entry_of_creation_operator_matrix_times_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`S\in\mathcal{P}_M`),
        " が ",
        math(String.raw`i\in S`),
        " を満たすとき、",
        math(String.raw`S'`),
        " を次の集合とする。",
      ]),
      displayMath(String.raw`S':=\{\,t\in\{1,\dots,M\}\ :\ t\in S\ \text{かつ}\ t\neq i\,\}.`),
      paragraph([
        math(String.raw`S'\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`S'\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）である。",
        math(String.raw`A\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）の成分は次のとおりである。",
      ]),
      displayMath(String.raw`\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{S',U} & (i\in S),\\
  0_{\mathbb{C}} & (i\notin S).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_i(S')\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）、",
        math(String.raw`\varsigma(N_i(S'))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。記号 ",
        math(String.raw`S'`),
        " は ",
        math(String.raw`S`),
        " と ",
        math(String.raw`i`),
        " を書かないが、",
        math(String.raw`S`),
        " と ",
        math(String.raw`i`),
        " ごとに別の集合である。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        math(String.raw`i\notin S`),
        " か ",
        math(String.raw`i\in S`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`i\notin S`),
          " のとき。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について次の等式を示す。",
          math(String.raw`S=T\cup\{i\}`),
          " なら ",
          math(String.raw`i\in S`),
          " となるので、",
          math(String.raw`i\notin S`),
          " から ",
          math(String.raw`S\neq T\cup\{i\}`),
          " であり、",
          math(String.raw`c_i`),
          " の定義の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`S=T\cup\{i\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&=(c_i)_{S,T}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \text{条件が成り立たないので}\ c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\text{（二回）}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \text{各}\ T\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}\right)
&&\left(\because\ \rho:=0_{\mathbb{C}}\text{、}\lambda_T:=1_{\mathbb{C}}\text{、}v_T:=1_{\mathbb{C}}\ \text{を当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ \text{零のスカラー倍は零ベクトル。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\in S`),
          " のとき。準備として、",
          math(String.raw`T\in\mathcal{P}_M`),
          " について、",
          math(String.raw`c_i`),
          " の定義の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`S=T\cup\{i\}`),
          "」が ",
          math(String.raw`T=S'`),
          " と同値であることを示す。",
          math(String.raw`\mathcal{P}_M`),
          " の二元が等しいことは、各 ",
          math(String.raw`t\in\{1,\dots,M\}`),
          " での所属が同値であることである（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
        [
          "条件が成り立つとする。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in S'`),
          " は ",
          math(String.raw`S'`),
          " の置き方で「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "」と同値であり、",
          math(String.raw`S=T\cup\{i\}`),
          " から「（",
          math(String.raw`t\in T`),
          " または ",
          math(String.raw`t=i`),
          "）かつ ",
          math(String.raw`t\neq i`),
          "」と同値であり、これは「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\neq i`),
          "」と同値である。",
          math(String.raw`i\notin T`),
          " なので ",
          math(String.raw`t\in T`),
          " なら ",
          math(String.raw`t\neq i`),
          " であり、これは ",
          math(String.raw`t\in T`),
          " と同値である。したがって ",
          math(String.raw`T=S'`),
          " である。",
        ],
        [
          math(String.raw`T=S'`),
          " とする。",
          math(String.raw`S'`),
          " の置き方で ",
          math(String.raw`i\notin S'`),
          " なので ",
          math(String.raw`i\notin T`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in T\cup\{i\}`),
          " は「（",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "）または ",
          math(String.raw`t=i`),
          "」と同値である。",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`i\in S`),
          " から ",
          math(String.raw`t\in S`),
          " なので、これは ",
          math(String.raw`t\in S`),
          " と同値である。したがって ",
          math(String.raw`S=T\cup\{i\}`),
          " であり、条件が成り立つ。",
        ],
      ]),
      paragraph([
        "次に、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`(c_i)_{S,T}=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))`),
        " を示す。",
        math(String.raw`\delta_{S',T}\in\mathbb{C}`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
        math(String.raw`T=S'`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}
&=\varsigma(N_i(T))
&&\left(\because\ T=S'\ \text{なので上の同値により条件が成り立ち、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))
&&\left(\because\ T=S'\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ S'=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq S'`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}
&=0_{\mathbb{C}}
&&\left(\because\ T\neq S'\ \text{なので上の同値により条件が成り立たず、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ S'\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "さらに、",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{T,U}\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項を次のように書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&=(c_i)_{S,T}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl(\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))\bigr)\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \text{上の準備の等式}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{T,U}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{S',T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_{S'}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S'\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{S',U}
&&\left(\because\ r_T\ \text{の置き方で}\ T:=S'\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ",
        math(String.raw`i\notin S`),
        " と ",
        math(String.raw`i\in S`),
        " を尽くすので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_creation_and_annihilation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "生成作用素の行列と消滅作用素の行列の反交換関係" },
    labels: ["claim_creation_and_annihilation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）、",
        math(String.raw`c_j^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とする。",
        math(String.raw`\delta_{i,j}\in\mathbb{C}`),
        " を集合 ",
        math(String.raw`\{1,\dots,M\}`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と単位行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i
=\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`S`),
        " から ",
        math(String.raw`i`),
        " を除いた集合を次のように置く。",
      ]),
      displayMath(String.raw`S':=\{\,t\in\{1,\dots,M\}\ :\ t\in S\ \text{かつ}\ t\neq i\,\}\in\mathcal{P}_M.`),
      paragraph([
        "これは左から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_creation_operator_matrix_times_matrix"),
        "）の ",
        math(String.raw`S'`),
        " と同じ式である（右辺の式は ",
        math(String.raw`i\notin S`),
        " のときも ",
        math(String.raw`\mathcal{P}_M`),
        " の元を定める）。",
        math(String.raw`S'`),
        " の置き方により ",
        math(String.raw`i\notin S'`),
        " である。また ",
        math(String.raw`i\in S`),
        " なら ",
        math(String.raw`S'\cup\{i\}=S`),
        " である（",
        math(String.raw`\sharp`),
        "）。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in S'\cup\{i\}`),
        " は「（",
        math(String.raw`t\in S`),
        " かつ ",
        math(String.raw`t\neq i`),
        "）または ",
        math(String.raw`t=i`),
        "」と同値であり、",
        math(String.raw`i\in S`),
        " なのでこれは ",
        math(String.raw`t\in S`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        " の元の等しさ）。",
      ]),
      paragraph([
        "準備。右辺の成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&=\delta_{i,j}\cdot_{\mathbb{C}}\bigl(1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ \ast_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ 1_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}
\qquad(\flat)`),
      paragraph([
        "準備。左辺の一つ目の項の成分について、条件 ",
        math(String.raw`\mathrm{D}_1`),
        " を「",
        math(String.raw`i\in S`),
        " かつ ",
        math(String.raw`j\notin S'`),
        " かつ ",
        math(String.raw`U=S'\cup\{j\}`),
        "」と置き、次の等式（",
        math(String.raw`\star_1`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S')) & (\mathrm{D}_1\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star_1)`),
      list([
        [
          math(String.raw`i\notin S`),
          " のとき。",
          math(String.raw`\mathrm{D}_1`),
          " は成り立たず、左から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_creation_operator_matrix_times_matrix"),
          "）を ",
          math(String.raw`A:=c_j^{\mathsf T}`),
          " に当てると、",
          math(String.raw`(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T})_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`i\in S`),
          " のとき。",
          math(String.raw`c_j`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で行の添字を ",
          math(String.raw`U`),
          "、列の添字を ",
          math(String.raw`S'`),
          " としたときの条件「",
          math(String.raw`j\notin S'`),
          " かつ ",
          math(String.raw`U=S'\cup\{j\}`),
          "」は、",
          math(String.raw`i\in S`),
          " のもとで ",
          math(String.raw`\mathrm{D}_1`),
          " と同値である。",
          math(String.raw`\mathrm{D}_1`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\bigl(c_j^{\mathsf T}\bigr)_{S',U}
&&\left(\because\ A:=c_j^{\mathsf T}\text{、}i\in S\text{。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}(c_j)_{U,S'}
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))
&&\left(\because\ \text{条件が成り立つので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{D}_1`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\bigl(c_j^{\mathsf T}\bigr)_{S',U}
&&\left(\because\ A:=c_j^{\mathsf T}\text{、}i\in S\text{。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}(c_j)_{U,S'}
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "準備。左辺の二つ目の項の成分について、条件 ",
        math(String.raw`\mathrm{D}_2`),
        " を「",
        math(String.raw`i\notin U`),
        " かつ ",
        math(String.raw`j\notin S`),
        " かつ ",
        math(String.raw`U\cup\{i\}=S\cup\{j\}`),
        "」と置き、次の等式（",
        math(String.raw`\star_2`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U)) & (\mathrm{D}_2\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star_2)`),
      list([
        [
          math(String.raw`i\in U`),
          " のとき。",
          math(String.raw`\mathrm{D}_2`),
          " は成り立たず、右から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_matrix_times_creation_operator_matrix"),
          "）を ",
          math(String.raw`A:=c_j^{\mathsf T}`),
          "、主張の ",
          math(String.raw`j`),
          " に ",
          math(String.raw`i`),
          " を当てると、",
          math(String.raw`(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i)_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`i\notin U`),
          " のとき。",
          math(String.raw`U\cup\{i\}\in\mathcal{P}_M`),
          " である。",
          math(String.raw`c_j`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で行の添字を ",
          math(String.raw`U\cup\{i\}`),
          "、列の添字を ",
          math(String.raw`S`),
          " としたときの条件「",
          math(String.raw`j\notin S`),
          " かつ ",
          math(String.raw`U\cup\{i\}=S\cup\{j\}`),
          "」は、",
          math(String.raw`i\notin U`),
          " のもとで ",
          math(String.raw`\mathrm{D}_2`),
          " と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_j^{\mathsf T}\bigr)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_j^{\mathsf T}\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_j)_{U\cup\{i\},S}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{D}_2`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_j^{\mathsf T}\bigr)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_j^{\mathsf T}\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_j)_{U\cup\{i\},S}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "本題。",
        math(String.raw`i=j`),
        " か ",
        math(String.raw`i\neq j`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`i=j`),
          " のとき。",
          math(String.raw`\delta_{i,j}=1_{\mathbb{C}}`),
          "（",
          ref("def_kronecker_delta"),
          "）である。まず、",
          math(String.raw`\mathrm{D}_1`),
          " は「",
          math(String.raw`i\in S`),
          " かつ ",
          math(String.raw`U=S`),
          "」と同値である。実際、",
          math(String.raw`j=i\notin S'`),
          " はつねに成り立ち、",
          math(String.raw`i\in S`),
          " なら（",
          math(String.raw`\sharp`),
          "）により ",
          math(String.raw`S'\cup\{j\}=S'\cup\{i\}=S`),
          " である。",
        ],
        [
          "次に、",
          math(String.raw`\mathrm{D}_2`),
          " は「",
          math(String.raw`i\notin S`),
          " かつ ",
          math(String.raw`U=S`),
          "」と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つとする。",
          math(String.raw`j=i`),
          " なので ",
          math(String.raw`i\notin S`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`t\notin U`),
          " かつ ",
          math(String.raw`t\notin S`),
          " であり、",
          math(String.raw`t\neq i`),
          " なら ",
          math(String.raw`t\in U`),
          "・",
          math(String.raw`t\in U\cup\{i\}`),
          "・",
          math(String.raw`t\in S\cup\{i\}`),
          "・",
          math(String.raw`t\in S`),
          " は順に同値である。したがって ",
          math(String.raw`U=S`),
          " である。逆に「",
          math(String.raw`i\notin S`),
          " かつ ",
          math(String.raw`U=S`),
          "」なら、",
          math(String.raw`i\notin U`),
          "、",
          math(String.raw`j=i\notin S`),
          "、",
          math(String.raw`U\cup\{i\}=S\cup\{i\}=S\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つ。",
        ],
        [
          math(String.raw`U=S`),
          " かつ ",
          math(String.raw`i\in S`),
          " なら、",
          math(String.raw`\mathrm{D}_1`),
          " は成り立ち、",
          math(String.raw`\mathrm{D}_2`),
          " は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \mathrm{D}_1\ \text{が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathrm{D}_2\ \text{が成り立たないので}\ (\star_2)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_i(S'))+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ j=i\right)\\
&\quad=1_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ n:=N_i(S')\ \text{を当てる。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&\quad=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U=S`),
          " かつ ",
          math(String.raw`i\notin S`),
          " なら、",
          math(String.raw`\mathrm{D}_1`),
          " は成り立たず、",
          math(String.raw`\mathrm{D}_2`),
          " は成り立つ。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \mathrm{D}_1\ \text{が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \mathrm{D}_2\ \text{が成り立つので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_i(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ j=i\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_i(S))\cdot_{\mathbb{C}}\varsigma(N_i(S))
&&\left(\because\ U=S\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ n:=N_i(S)\ \text{を当てる。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&\quad=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U\neq S`),
          " なら、上の二つの同値により ",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\neq j`),
          " のとき。",
          math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`),
          "（",
          ref("def_kronecker_delta"),
          "）である。条件 ",
          math(String.raw`\mathrm{D}`),
          " を「",
          math(String.raw`i\in S`),
          " かつ ",
          math(String.raw`j\notin S`),
          " かつ ",
          math(String.raw`U=S'\cup\{j\}`),
          "」と置く。",
          math(String.raw`j\neq i`),
          " なので、",
          math(String.raw`S'`),
          " の置き方により ",
          math(String.raw`j\notin S'`),
          " と ",
          math(String.raw`j\notin S`),
          " は同値であり、",
          math(String.raw`\mathrm{D}_1`),
          " は ",
          math(String.raw`\mathrm{D}`),
          " と同値である。",
        ],
        [
          math(String.raw`\mathrm{D}_2`),
          " も ",
          math(String.raw`\mathrm{D}`),
          " と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つとする。",
          math(String.raw`i\in U\cup\{i\}=S\cup\{j\}`),
          " と ",
          math(String.raw`i\neq j`),
          " から ",
          math(String.raw`i\in S`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`t\notin U`),
          " かつ ",
          math(String.raw`t\notin S'\cup\{j\}`),
          "（",
          math(String.raw`i\notin S'`),
          " と ",
          math(String.raw`i\neq j`),
          "）であり、",
          math(String.raw`t\neq i`),
          " なら ",
          math(String.raw`t\in U`),
          "・",
          math(String.raw`t\in U\cup\{i\}`),
          "・",
          math(String.raw`t\in S\cup\{j\}`),
          "・「（",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "）または ",
          math(String.raw`t=j`),
          "」・",
          math(String.raw`t\in S'\cup\{j\}`),
          " は順に同値である。したがって ",
          math(String.raw`U=S'\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}`),
          " が成り立つ。逆に ",
          math(String.raw`\mathrm{D}`),
          " が成り立つとする。",
          math(String.raw`i\notin S'`),
          " と ",
          math(String.raw`i\neq j`),
          " から ",
          math(String.raw`i\notin S'\cup\{j\}=U`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in U\cup\{i\}`),
          " は「",
          math(String.raw`t\in S'\cup\{i\}`),
          " または ",
          math(String.raw`t=j`),
          "」と同値であり、（",
          math(String.raw`\sharp`),
          "）によりこれは ",
          math(String.raw`t\in S\cup\{j\}`),
          " と同値である。したがって ",
          math(String.raw`U\cup\{i\}=S\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つ。",
        ],
        [
          math(String.raw`\mathrm{D}`),
          " が成り立たないなら、",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`\mathrm{D}`),
          " が成り立つなら、",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立つ。",
          math(String.raw`i\in S`),
          " なので（",
          math(String.raw`\sharp`),
          "）により ",
          math(String.raw`S=S'\cup\{i\}`),
          "、また ",
          math(String.raw`U=S'\cup\{j\}`),
          " であり、",
          math(String.raw`i\notin S'`),
          "、",
          math(String.raw`j\notin S'`),
          " である。部分集合に一つの元を足したときの個数の値の主張（",
          ref("claim_count_below_index_after_adding_one_element"),
          "）を ",
          math(String.raw`T:=S'`),
          " に当てる。",
          math(String.raw`\alpha:=\varsigma(N_i(S'))\in\mathbb{C}`),
          "、",
          math(String.raw`\beta:=\varsigma(N_j(S'))\in\mathbb{C}`),
          " と置く。",
          math(String.raw`i,j`),
          " は整数なので ",
          math(String.raw`j<i`),
          " か ",
          math(String.raw`i<j`),
          " のどちらか一方である。",
          math(String.raw`j<i`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_2)\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ S=S'\cup\{i\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ U=S'\cup\{j\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i\ge j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S')+1\bigr)
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j<i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_i(S'))\bigr)
&&\left(\because\ n:=N_i(S')+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_i(S')\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\beta\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\alpha\bigr)
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\alpha\bigr)\cdot_{\mathbb{C}}\beta
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i<j`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_2)\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ S=S'\cup\{i\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ U=S'\cup\{j\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S')+1\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i<j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S')+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j\ge i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_j(S'))\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ n:=N_j(S')+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_j(S')\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\beta\bigr)\cdot_{\mathbb{C}}\alpha
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\beta\cdot_{\mathbb{C}}\alpha)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      paragraph([
        "場合分けはすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_count_below_index_vanishes_without_smaller_elements",
    kind: "claim",
    title: { text: "番号より小さい元を持たない部分集合の、番号より小さい元を数える個数は 0 であること" },
    labels: ["claim_count_below_index_vanishes_without_smaller_elements"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすなら、部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）は次を満たす。",
      ]),
      displayMath(String.raw`N_i(T)=0.`),
    ],
    proof: [
      paragraph([
        math(String.raw`T`),
        " を固定し、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " についての帰納法で、命題「",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすなら ",
        math(String.raw`N_i(T)=0`),
        "」を示す。",
        math(String.raw`M=0`),
        " なら ",
        math(String.raw`\{1,\dots,M\}`),
        " は空集合なので、示すことは無い。",
      ]),
      paragraph([
        math(String.raw`i=1`),
        " のとき。",
        math(String.raw`T`),
        " の元についての仮定を使わずに次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_1(T)
&=0
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`i-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすとする。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`T`),
        " の各元 ",
        math(String.raw`t`),
        " について ",
        math(String.raw`t\ge i>i-1`),
        " なので、",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i-1`),
        " を満たす。したがって帰納法の仮定から ",
        math(String.raw`N_{i-1}(T)=0`),
        " である（",
        math(String.raw`\star`),
        "）。また ",
        math(String.raw`i-1\in T`),
        " なら仮定から ",
        math(String.raw`i-1\ge i`),
        " となり ",
        math(String.raw`i-1<i`),
        " に反するので、",
        math(String.raw`i-1\notin T`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T)
&=N_{i-1}(T)
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=0
&&\left(\because\ (\star)\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について命題が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit",
    kind: "claim",
    title: { text: "消滅作用素の行列と生成作用素の行列の積を番号順に掛けると、空集合の位置の行列単位になること" },
    labels: ["claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）、",
        math(String.raw`c_i^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とし、",
      ]),
      displayMath(String.raw`x_i:=c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
      paragraph([
        "と置く（",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        " は行列の積。",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`x_1,\dots,x_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "）と、",
        math(String.raw`\emptyset\in\mathcal{P}_M`),
        " の位置の行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset}`),
        "（",
        ref("def_matrix_unit"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i=E_{\emptyset,\emptyset}.`),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\delta`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
      ]),
      paragraph([
        "記号の準備。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`U\in\mathcal{P}_M`),
        " について、",
        math(String.raw`\eta_i(U)\in\mathbb{C}`),
        " を、",
        math(String.raw`i\notin U`),
        " なら ",
        math(String.raw`\eta_i(U):=1_{\mathbb{C}}`),
        "、",
        math(String.raw`i\in U`),
        " なら ",
        math(String.raw`\eta_i(U):=0_{\mathbb{C}}`),
        " と定める（",
        math(String.raw`i\in U`),
        " の真偽は ",
        ref("def_power_set_of_first_m_positive_integers"),
        " により一つに決まる）。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、条件 ",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " を「",
        math(String.raw`S=U`),
        " かつ、",
        math(String.raw`t\in S`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,m\}`),
        " が無い」と定め、",
        math(String.raw`\chi_m(S,U)\in\mathbb{C}`),
        " を、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら ",
        math(String.raw`1_{\mathbb{C}}`),
        "、成り立たないなら ",
        math(String.raw`0_{\mathbb{C}}`),
        " と定める。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`x_1,\dots,x_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}x_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i`),
        " である。",
      ]),
      paragraph([
        "準備の一つ目。すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`T,U\in\mathcal{P}_M`),
        " について、次を示す。",
      ]),
      displayMath(String.raw`(x_i)_{T,U}=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)\qquad(\star_1).`),
      paragraph([
        "右から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_matrix_times_creation_operator_matrix"),
        "）を ",
        math(String.raw`A:=c_i^{\mathsf T}`),
        "、",
        math(String.raw`j:=i`),
        "、主張の ",
        math(String.raw`S`),
        " に ",
        math(String.raw`T`),
        " を当てて使う。",
        math(String.raw`i\in U`),
        " か ",
        math(String.raw`i\notin U`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`i\in U`),
          " のとき。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ i\in U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ i\in U\ \text{なので}\ \eta_i\ \text{の置き方}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\notin U`),
          " のとき。まず、",
          math(String.raw`c_i`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の ",
          math(String.raw`(U\cup\{i\},T)`),
          " 成分の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`U\cup\{i\}=T\cup\{i\}`),
          "」が ",
          math(String.raw`T=U`),
          " と同値であることを示す。",
          math(String.raw`T=U`),
          " なら、",
          math(String.raw`i\notin U`),
          " から ",
          math(String.raw`i\notin T`),
          " であり、",
          math(String.raw`U\cup\{i\}=T\cup\{i\}`),
          " である。逆に条件が成り立つとする。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " が ",
          math(String.raw`t\neq i`),
          " なら、",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in T\cup\{i\}`),
          " と ",
          math(String.raw`t\in U\cup\{i\}`),
          " と ",
          math(String.raw`t\in U`),
          " は同値である。",
          math(String.raw`t=i`),
          " なら、",
          math(String.raw`i\notin T`),
          " と ",
          math(String.raw`i\notin U`),
          " から、",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in U`),
          " はどちらも成り立たない。したがってすべての ",
          math(String.raw`t\in\{1,\dots,M\}`),
          " で ",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in U`),
          " は同値であり、",
          math(String.raw`T=U`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
          math(String.raw`T=U`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=(c_i^{\mathsf T})_{T,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ i\notin U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_i)_{U\cup\{i\},T}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(T))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T=U\ \text{なので条件が成り立ち、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T=U\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{符号の自分自身との積。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ U=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ i\notin U\ \text{なので}\ \eta_i\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=(c_i^{\mathsf T})_{T,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ i\notin U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_i)_{U\cup\{i\},T}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T\neq U\ \text{なので条件が成り立たず、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ U\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "準備の二つ目。すべての ",
        math(String.raw`m\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、次を示す。",
      ]),
      displayMath(String.raw`\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)=\chi_m(S,U)\qquad(\star_2).`),
      paragraph([
        "まず、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が「",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " かつ ",
        math(String.raw`m\notin U`),
        "」と同値であることを示す。",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら、",
        math(String.raw`\{1,\dots,m-1\}\subseteq\{1,\dots,m\}`),
        " なので ",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " が成り立ち、",
        math(String.raw`m\in\{1,\dots,m\}`),
        " なので ",
        math(String.raw`m\notin S`),
        "、",
        math(String.raw`S=U`),
        " から ",
        math(String.raw`m\notin U`),
        " である。逆に「",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " かつ ",
        math(String.raw`m\notin U`),
        "」が成り立つなら、",
        math(String.raw`S=U`),
        " であり、",
        math(String.raw`t\in\{1,\dots,m\}`),
        " は ",
        math(String.raw`t\le m-1`),
        " なら ",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " から、",
        math(String.raw`t=m`),
        " なら ",
        math(String.raw`m\notin U=S`),
        " から ",
        math(String.raw`t\notin S`),
        " を満たすので、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つ。",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathrm{C}_{m-1}(S,U)\ \text{が成り立つので}\ \chi_{m-1}\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ m\notin U\ \text{なので}\ \eta_m\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立つので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立たず、",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " も成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathrm{C}_{m-1}(S,U)\ \text{が成り立たないので}\ \chi_{m-1}\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立たないので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立たず、",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " が成り立つなら、上の同値から ",
        math(String.raw`m\in U`),
        " であり、次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=\chi_{m-1}(S,U)\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ m\in U\ \text{なので}\ \eta_m\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立たないので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、命題「すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について ",
        math(String.raw`(\Pi_m)_{S,U}=\chi_m(S,U)`),
        "」を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合なので、",
        math(String.raw`\mathrm{C}_0(S,U)`),
        " は ",
        math(String.raw`S=U`),
        " と同値である。",
        math(String.raw`S=U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_0)_{S,U}
&=(1_{\mathrm{Mat}_{\mathcal{P}_M}})_{S,U}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\delta_{S,U}
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\chi_0(S,U)
&&\left(\because\ \mathrm{C}_0(S,U)\ \text{が成り立つので}\ \chi_0\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S\neq U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_0)_{S,U}
&=(1_{\mathrm{Mat}_{\mathcal{P}_M}})_{S,U}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\delta_{S,U}
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ S\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\chi_0(S,U)
&&\left(\because\ \mathrm{C}_0(S,U)\ \text{が成り立たないので}\ \chi_0\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`m-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\eta_m(U)\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項のデルタを係数の位置へ移した次の等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(x_m)_{T,U}
&=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}(x_m)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\bigl(\delta_{U,T}\cdot_{\mathbb{C}}\eta_m(U)\bigr)
&&\left(\because\ (\star_1)\ \text{を}\ i:=m\ \text{に当てる}\right)\\
&=\bigl((\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\delta_{U,T}\bigr)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\bigl(\delta_{U,T}\cdot_{\mathbb{C}}(\Pi_{m-1})_{S,T}\bigr)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\bigl((\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\eta_m(U)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_m)_{S,U}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}x_m\bigr)_{S,U}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\sum_{T\in\mathcal{P}_M}(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(x_m)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_U
&&\left(\because\ \text{主張の}\ x\ \text{に}\ U\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=(\Pi_{m-1})_{S,U}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ r_T\ \text{の置き方で}\ T:=U\right)\\
&=\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\chi_m(S,U)
&&\left(\because\ (\star_2)\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について命題が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が「",
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U=\emptyset`),
        "」と同値であることを示す。",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が成り立つなら、すべての ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`t\notin S`),
        " かつ ",
        math(String.raw`t\notin\emptyset`),
        " なので ",
        math(String.raw`S=\emptyset`),
        " であり（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）、",
        math(String.raw`U=S=\emptyset`),
        " である。逆に ",
        math(String.raw`S=U=\emptyset`),
        " なら、",
        math(String.raw`S=U`),
        " であり、",
        math(String.raw`t\in S`),
        " を満たす ",
        math(String.raw`t`),
        " は無いので、",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が成り立つ。",
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U=\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立つので}\ \chi_M\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset=S\ \text{と}\ \emptyset=U\ \text{なので}\ \delta\ \text{の定義（二回）。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S\neq\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立たないので}\ \chi_M\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset\neq S\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U\neq\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立たないので}\ \chi_M\ \text{の置き方}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "三つの場合はすべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、",
        math(String.raw`\Pi_M`),
        " と ",
        math(String.raw`E_{\emptyset,\emptyset}`),
        " の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i`),
        " なので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit",
    kind: "claim",
    title: { text: "部分集合の元の番号の生成作用素の行列を番号順に掛けた積を、空集合の位置の行列単位に左から掛けると、その部分集合の行の行列単位になること" },
    labels: ["claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`S\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とし、",
        math(String.raw`y_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、",
        math(String.raw`t\in S`),
        " なら ",
        math(String.raw`y_t:=c_t`),
        "、",
        math(String.raw`t\notin S`),
        " なら ",
        math(String.raw`y_t:=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（単位行列。",
        ref("def_matrices_indexed_by_finite_set"),
        "）と定める。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`y_1,\dots,y_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "）と、行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset},\ E_{S,\emptyset}`),
        "（",
        ref("def_matrix_unit"),
        "）について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t\Bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}=E_{S,\emptyset}.`),
    ],
    proof: [
      paragraph([
        "記号の準備。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`y_1,\dots,y_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t`),
        " である。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " と ",
        math(String.raw`R\in\mathcal{P}_M`),
        " について、次の集合を置く。",
      ]),
      displayMath(String.raw`R^{\langle m\rangle}:=\{\,t\in\{1,\dots,M\}\ :\ t\in R\ \text{であるか、または}\ t\in S\ \text{かつ}\ t\le m\,\}.`),
      paragraph([
        math(String.raw`R^{\langle m\rangle}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R^{\langle m\rangle}\in\mathcal{P}_M`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。記号 ",
        math(String.raw`R^{\langle m\rangle}`),
        " は ",
        math(String.raw`S`),
        " を書かないが、",
        math(String.raw`S`),
        " ごとに別の集合である。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすとする。このとき ",
        math(String.raw`m\notin R`),
        " であり、",
        math(String.raw`R\cup\{m\}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R\cup\{m\}\in\mathcal{P}_M`),
        " である。次を示す。",
      ]),
      displayMath(String.raw`c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}=E_{R\cup\{m\},\emptyset}\qquad(\star).`),
      paragraph([
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`(X,U)`),
        " 成分を比べる。左から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_creation_operator_matrix_times_matrix"),
        "）を ",
        math(String.raw`i:=m`),
        "、",
        math(String.raw`A:=E_{R,\emptyset}`),
        "、主張の ",
        math(String.raw`S`),
        " に ",
        math(String.raw`X`),
        " を当てて使う。",
        math(String.raw`m\in X`),
        " のときは、その主張の ",
        math(String.raw`S'`),
        " に当たる集合を ",
        math(String.raw`X':=\{\,t\in\{1,\dots,M\}: t\in X\ \text{かつ}\ t\neq m\,\}`),
        " と書く。",
      ]),
      list([
        [
          math(String.raw`m\notin X`),
          " のとき。",
          math(String.raw`m\in R\cup\{m\}`),
          " と ",
          math(String.raw`m\notin X`),
          " から ",
          math(String.raw`R\cup\{m\}\neq X`),
          " である。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=0_{\mathbb{C}}
&&\left(\because\ m\notin X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}\neq X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`X'=R`),
          " のとき。まず ",
          math(String.raw`X=R\cup\{m\}`),
          " を示す。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " が ",
          math(String.raw`t\neq m`),
          " なら、",
          math(String.raw`t\in X`),
          " と ",
          math(String.raw`t\in X'`),
          " と ",
          math(String.raw`t\in R`),
          " と ",
          math(String.raw`t\in R\cup\{m\}`),
          " は同値である。",
          math(String.raw`t=m`),
          " なら、",
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`m\in R\cup\{m\}`),
          " である。したがって ",
          math(String.raw`X=R\cup\{m\}`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。また ",
          math(String.raw`R`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m+1>m`),
          " を満たすので、",
          math(String.raw`N_m(R)=0`),
          " である（",
          ref("claim_count_below_index_vanishes_without_smaller_elements"),
          " を ",
          math(String.raw`i:=m`),
          "、",
          math(String.raw`T:=R`),
          " に当てる）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{X',U}
&&\left(\because\ m\in X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_m(R))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ X'=R\right)\\
&=\varsigma(0)\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ N_m(R)=0\text{。}\blkref{claim_count_below_index_vanishes_without_smaller_elements}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ \varsigma(0)\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{R,R}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}=X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`X'\neq R`),
          " のとき。まず ",
          math(String.raw`X\neq R\cup\{m\}`),
          " を示す。",
          math(String.raw`X=R\cup\{m\}`),
          " と仮定すると、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in X'`),
          " は「",
          math(String.raw`t\in R\cup\{m\}`),
          " かつ ",
          math(String.raw`t\neq m`),
          "」と同値であり、それは「",
          math(String.raw`t\in R`),
          " かつ ",
          math(String.raw`t\neq m`),
          "」と同値であり、",
          math(String.raw`m\notin R`),
          " なのでそれは ",
          math(String.raw`t\in R`),
          " と同値である。すると ",
          math(String.raw`X'=R`),
          " となり（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）、",
          math(String.raw`X'\neq R`),
          " に反する。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{X',U}
&&\left(\because\ m\in X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(\delta_{R,X'}\cdot_{\mathbb{C}}\delta_{\emptyset,U}\bigr)
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}\bigr)
&&\left(\because\ R\neq X'\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}\neq X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "三つの場合はすべての ",
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。これで（",
        math(String.raw`\star`),
        "）が示された。",
      ]),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、命題「",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすなら ",
        math(String.raw`\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}=E_{R^{\langle m\rangle},\emptyset}`),
        "」を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`t\le 0`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " は無いので、",
        math(String.raw`t\in R^{\langle 0\rangle}`),
        " は ",
        math(String.raw`t\in R`),
        " と同値であり、",
        math(String.raw`R^{\langle 0\rangle}=R`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_0\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=1_{\mathrm{Mat}_{\mathcal{P}_M}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=E_{R,\emptyset}
&&\left(\because\ \text{単位行列を左から掛けても変わらない。}\blkref{claim_identity_matrix_is_left_unit_of_matrix_product}\right)\\
&=E_{R^{\langle 0\rangle},\emptyset}
&&\left(\because\ R=R^{\langle 0\rangle}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`m-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすとする。",
        math(String.raw`m\in S`),
        " か ",
        math(String.raw`m\notin S`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`m\in S`),
          " のとき。",
          math(String.raw`R\cup\{m\}`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m=(m-1)+1`),
          " を満たすので、帰納法の仮定を ",
          math(String.raw`R\cup\{m\}`),
          " に当てられる。また ",
          math(String.raw`(R\cup\{m\})^{\langle m-1\rangle}=R^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in(R\cup\{m\})^{\langle m-1\rangle}`),
          " は「",
          math(String.raw`t\in R`),
          "、または ",
          math(String.raw`t=m`),
          "、または ",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」と同値であり、",
          math(String.raw`m\in S`),
          " なので「",
          math(String.raw`t=m`),
          "、または ",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」は「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(y_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ m\in S\ \text{なので}\ y_m\ \text{の定め方}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R\cup\{m\},\emptyset}
&&\left(\because\ (\star)\right)\\
&=E_{(R\cup\{m\})^{\langle m-1\rangle},\emptyset}
&&\left(\because\ \text{帰納法の仮定を}\ R\cup\{m\}\ \text{に当てる}\right)\\
&=E_{R^{\langle m\rangle},\emptyset}
&&\left(\because\ (R\cup\{m\})^{\langle m-1\rangle}=R^{\langle m\rangle}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\notin S`),
          " のとき。",
          math(String.raw`R`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m+1>m=(m-1)+1`),
          " を満たすので、帰納法の仮定を ",
          math(String.raw`R`),
          " に当てられる。また ",
          math(String.raw`R^{\langle m-1\rangle}=R^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`m\notin S`),
          " なので、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m`),
          "」は「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(y_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(1_{\mathrm{Mat}_{\mathcal{P}_M}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ m\notin S\ \text{なので}\ y_m\ \text{の定め方}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \text{単位行列を左から掛けても変わらない。}\blkref{claim_identity_matrix_is_left_unit_of_matrix_product}\right)\\
&=E_{R^{\langle m-1\rangle},\emptyset}
&&\left(\because\ \text{帰納法の仮定を}\ R\ \text{に当てる}\right)\\
&=E_{R^{\langle m\rangle},\emptyset}
&&\left(\because\ R^{\langle m-1\rangle}=R^{\langle m\rangle}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について命題が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`\emptyset\in\mathcal{P}_M`),
        " は元を持たないので、",
        math(String.raw`m:=M`),
        "、",
        math(String.raw`R:=\emptyset`),
        " に前半の命題を当てられる。また ",
        math(String.raw`\emptyset^{\langle M\rangle}=S`),
        " である。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in\emptyset`),
        " は成り立たず ",
        math(String.raw`t\le M`),
        " は成り立つので、",
        math(String.raw`t\in\emptyset^{\langle M\rangle}`),
        " は ",
        math(String.raw`t\in S`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t\Bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}
&=\Pi_M\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}
&&\left(\because\ \Pi_M\ \text{の置き方}\right)\\
&=E_{\emptyset^{\langle M\rangle},\emptyset}
&&\left(\because\ \text{前半の命題で}\ m:=M\text{、}R:=\emptyset\right)\\
&=E_{S,\emptyset}
&&\left(\because\ \emptyset^{\langle M\rangle}=S\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices",
    kind: "claim",
    title: { text: "空集合の位置の行列単位に、部分集合の元の番号の消滅作用素の行列を番号の逆順に右から掛けると、その部分集合の列の行列単位になること" },
    labels: ["claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_t^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とし、",
        math(String.raw`z_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、",
        math(String.raw`t\in T`),
        " なら ",
        math(String.raw`z_t:=c_t^{\mathsf T}`),
        "、",
        math(String.raw`t\notin T`),
        " なら ",
        math(String.raw`z_t:=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（単位行列。",
        ref("def_matrices_indexed_by_finite_set"),
        "）と定める。",
        math(String.raw`k\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`M+1-k\in\{1,\dots,M\}`),
        " なので、番号を逆順に並べ直した族 ",
        math(String.raw`w_k:=z_{M+1-k}`),
        " が定まる。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`w_1,\dots,w_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "。",
        math(String.raw`z_M,\dots,z_1`),
        " をこの順に掛けた積である）と、行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset},\ E_{\emptyset,T}`),
        "（",
        ref("def_matrix_unit"),
        "）について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}w_k\Bigr)=E_{\emptyset,T}.`),
    ],
    proof: [
      paragraph([
        "記号の準備。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`w_1,\dots,w_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}w_k`),
        " である。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、次の集合を置く。",
      ]),
      displayMath(String.raw`T^{\langle m\rangle}:=\{\,t\in\{1,\dots,M\}\ :\ t\in T\ \text{かつ}\ t\ge M+1-m\,\}.`),
      paragraph([
        math(String.raw`T^{\langle m\rangle}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`T^{\langle m\rangle}\in\mathcal{P}_M`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      paragraph([
        "準備。和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。",
        math(String.raw`s\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge s+1`),
        " を満たすとする。このとき ",
        math(String.raw`s\notin R`),
        " であり、",
        math(String.raw`R\cup\{s\}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R\cup\{s\}\in\mathcal{P}_M`),
        " である。また ",
        math(String.raw`R`),
        " のすべての元 ",
        math(String.raw`t`),
        " は ",
        math(String.raw`t\ge s+1>s`),
        " を満たすので、",
        math(String.raw`N_s(R)=0`),
        " である（",
        ref("claim_count_below_index_vanishes_without_smaller_elements"),
        " を ",
        math(String.raw`i:=s`),
        "、",
        math(String.raw`T:=R`),
        " に当てる）。次を示す。",
      ]),
      displayMath(String.raw`E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}=E_{\emptyset,R\cup\{s\}}\qquad(\star).`),
      paragraph([
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`(X,U)`),
        " 成分を比べる。",
        math(String.raw`Y\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_Y:=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,Y}\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`Y\in\mathcal{P}_M`),
        " について、和の項を次のように書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_s^{\mathsf T})_{Y,U}
&=(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R,Y}\bigr)\cdot_{\mathbb{C}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R,Y}\bigr)\cdot_{\mathbb{C}}(c_s)_{U,Y}
&&\left(\because\ c_s^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\bigl(\delta_{R,Y}\cdot_{\mathbb{C}}\delta_{\emptyset,X}\bigr)\cdot_{\mathbb{C}}(c_s)_{U,Y}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}}\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,Y}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}}r_Y
&&\left(\because\ r_Y\ \text{の置き方}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_Y
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(X,U)`),
        " 成分を開く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\sum_{Y\in\mathcal{P}_M}(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{Y\in\mathcal{P}_M}\delta_{R,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_Y
&&\left(\because\ \text{各}\ Y\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_R
&&\left(\because\ \text{主張の}\ x\ \text{に}\ R\text{、和の変数に}\ Y\text{、}v_Y:=r_Y\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ r_Y\ \text{の置き方で}\ Y:=R\right).
\end{aligned}\qquad(\dagger)`),
      paragraph([
        math(String.raw`U=R\cup\{s\}`),
        " か ",
        math(String.raw`U\neq R\cup\{s\}`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`U=R\cup\{s\}`),
          " のとき。",
          math(String.raw`s\notin R`),
          " なので、",
          math(String.raw`c_s`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の条件「",
          math(String.raw`s\notin R`),
          " かつ ",
          math(String.raw`U=R\cup\{s\}`),
          "」が成り立つ。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ (\dagger)\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\varsigma(N_s(R))
&&\left(\because\ \text{条件が成り立つので}\ c_s\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\varsigma(0)
&&\left(\because\ N_s(R)=0\text{。}\blkref{claim_count_below_index_vanishes_without_smaller_elements}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \varsigma(0)\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R\cup\{s\},U}
&&\left(\because\ R\cup\{s\}=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{\emptyset,R\cup\{s\}}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U\neq R\cup\{s\}`),
          " のとき。",
          math(String.raw`c_s`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の条件「",
          math(String.raw`s\notin R`),
          " かつ ",
          math(String.raw`U=R\cup\{s\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ (\dagger)\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_s\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R\cup\{s\},U}
&&\left(\because\ R\cup\{s\}\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{\emptyset,R\cup\{s\}}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "二つの場合はすべての ",
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。これで（",
        math(String.raw`\star`),
        "）が示された。",
      ]),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m=E_{\emptyset,T^{\langle m\rangle}}`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`t\ge M+1`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " は無いので、",
        math(String.raw`T^{\langle 0\rangle}`),
        " は元を持たず、",
        math(String.raw`T^{\langle 0\rangle}=\emptyset`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_0
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=E_{\emptyset,\emptyset}
&&\left(\because\ \text{単位行列を右から掛けても変わらない。}\blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right)\\
&=E_{\emptyset,T^{\langle 0\rangle}}
&&\left(\because\ \emptyset=T^{\langle 0\rangle}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}=E_{\emptyset,T^{\langle m-1\rangle}}`),
        " を仮定する（帰納法の仮定）。",
        math(String.raw`s:=M+1-m\in\{1,\dots,M\}`),
        " と置く。",
        math(String.raw`w_m=z_s`),
        " である（",
        math(String.raw`w_m`),
        " の定め方）。",
        math(String.raw`T^{\langle m-1\rangle}`),
        " のすべての元 ",
        math(String.raw`t`),
        " は ",
        math(String.raw`t\ge M+1-(m-1)=s+1`),
        " を満たす。",
        math(String.raw`s\in T`),
        " か ",
        math(String.raw`s\notin T`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`s\in T`),
          " のとき。",
          math(String.raw`T^{\langle m-1\rangle}\cup\{s\}=T^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in T^{\langle m\rangle}`),
          " は「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s`),
          "」と同値であり、それは「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s+1`),
          "、または ",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t=s`),
          "」と同値であり、",
          math(String.raw`s\in T`),
          " なのでそれは「",
          math(String.raw`t\in T^{\langle m-1\rangle}`),
          "、または ",
          math(String.raw`t=s`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m\bigr)
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\bigl(E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}
&&\left(\because\ w_m=z_s\ \text{で、}s\in T\ \text{なので}\ z_s\ \text{の定め方}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}\cup\{s\}}
&&\left(\because\ R:=T^{\langle m-1\rangle}\ \text{で}\ (\star)\right)\\
&=E_{\emptyset,T^{\langle m\rangle}}
&&\left(\because\ T^{\langle m-1\rangle}\cup\{s\}=T^{\langle m\rangle}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`s\notin T`),
          " のとき。",
          math(String.raw`T^{\langle m-1\rangle}=T^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`s\notin T`),
          " なので、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s`),
          "」は「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s+1`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m\bigr)
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\bigl(E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}w_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ w_m=z_s\ \text{で、}s\notin T\ \text{なので}\ z_s\ \text{の定め方}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}
&&\left(\because\ \text{単位行列を右から掛けても変わらない。}\blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right)\\
&=E_{\emptyset,T^{\langle m\rangle}}
&&\left(\because\ T^{\langle m-1\rangle}=T^{\langle m\rangle}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について ",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m=E_{\emptyset,T^{\langle m\rangle}}`),
        " が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`T^{\langle M\rangle}=T`),
        " である。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\ge 1=M+1-M`),
        " は成り立つので、",
        math(String.raw`t\in T^{\langle M\rangle}`),
        " は ",
        math(String.raw`t\in T`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}w_k\Bigr)
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_M
&&\left(\because\ \Pi_M\ \text{の置き方}\right)\\
&=E_{\emptyset,T^{\langle M\rangle}}
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=E_{\emptyset,T}
&&\left(\because\ T^{\langle M\rangle}=T\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_homomorphism_to_matrix_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数から行列環への準同型" },
    labels: [],
  },
  {
    id: "isomorphism_claim_square_of_creation_operator_matrix_is_zero",
    kind: "claim",
    title: { text: "生成作用素の行列の自分自身との積は零行列である" },
    labels: ["claim_square_of_creation_operator_matrix_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`i\in\{1,\dots,M\}`), " について ", math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（", ref("def_creation_operator_matrix"), "）とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i=0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "行列の等しさの定義（", ref("def_matrices_indexed_by_finite_set"), "）により、すべての ", math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ", math(String.raw`(S,U)`), " 成分が等しいことを示せばよい。", math(String.raw`S,U\in\mathcal{P}_M`), " を固定し、",
        math(String.raw`i\in U`), " か ", math(String.raw`i\notin U`), " かで場合を分ける。", math(String.raw`i\in U`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=0_{\mathbb{C}}
&&\left(\because\ A:=c_i\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\in U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\notin U`), " のとき。", math(String.raw`i\in U\cup\{i\}`), " なので、", math(String.raw`c_i`), " の定義（",
        ref("def_creation_operator_matrix"), "）で列の添字を ", math(String.raw`U\cup\{i\}`), " としたときの条件「", math(String.raw`i\notin U\cup\{i\}`),
        " かつ ", math(String.raw`S=(U\cup\{i\})\cup\{i\}`), "」は成り立たない。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=(c_i)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_i\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ", math(String.raw`i\in U`), " と ", math(String.raw`i\notin U`), " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_annihilation_operator_matrix_is_zero",
    kind: "claim",
    title: { text: "消滅作用素の行列の自分自身との積は零行列である" },
    labels: ["claim_square_of_annihilation_operator_matrix_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`i\in\{1,\dots,M\}`), " について ",
        math(String.raw`c_i^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"),
        "）とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}=0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "和はすべて ℂ-線型空間 ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), "（", ref("def_complex_numbers_as_complex_vector_space"), "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"), "）の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。", math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。準備として、各 ", math(String.raw`T\in\mathcal{P}_M`), " について和の項を書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i^{\mathsf T})_{T,U}
&=(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}}(c_i^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(c_i)_{T,S}\cdot_{\mathbb{C}}(c_i)_{U,T}
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義を二か所に適用。}\blkref{def_annihilation_operator_matrix}\right)\\
&=(c_i)_{U,T}\cdot_{\mathbb{C}}(c_i)_{T,S}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(c_i)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i)_{T,S}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["これを使って ", math(String.raw`(S,U)`), " 成分を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(c_i)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i)_{T,S}
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{U,S}
&&\left(\because\ \text{生成作用素の行列の自分自身との積。}\blkref{claim_square_of_creation_operator_matrix_is_zero}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S,U\in\mathcal{P}_M`), " は任意なので、行列の等しさの定義（", ref("def_matrices_indexed_by_finite_set"), "）により主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_matrix_valued_map_on_split_quadratic_space",
    kind: "definition",
    title: { text: "分裂した二次空間から行列環への写像" },
    labels: ["def_matrix_valued_map_on_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`w_k`), "、", math(String.raw`V=W\oplus W^{*}`),
        " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとする。", math(String.raw`k\in\{1,\dots,M\}`), " について、",
        math(String.raw`\beta^{w}_k:W\to\mathbb{C}`), " を基底 ", math(String.raw`w`), " についての第 ", math(String.raw`k`), " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"), "）、", math(String.raw`c_k`), " を生成作用素の行列（", ref("def_creation_operator_matrix"), "）、",
        math(String.raw`c_k^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"), "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " は ℂ-代数であり（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）、",
        "以下の二つの和は ℂ-線型空間 ", math(String.raw`U_{\mathrm{vec}}(\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C}))`), "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（", ref("def_linear_combination"), "）である。",
      ]),
      paragraph([
        math(String.raw`V`), " の各元は、", math(String.raw`x\in W`), " と ", math(String.raw`g\in W^{*}`), " の順序対 ", math(String.raw`(x,g)`),
        " としてただ一通りに書ける（", ref("def_direct_sum_of_two_vector_spaces"), "）。写像 ", math(String.raw`\varphi:V\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を次で定める。",
      ]),
      displayMath(String.raw`\varphi\bigl((x,g)\bigr):=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\right)+_{\mathrm{Mat}_{\mathcal{P}_M}}\left(\sum_{k=1}^{M}g(w_k)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}c_k^{\mathsf T}\right)`),
      paragraph([
        math(String.raw`\beta^{w}_k(x)\in\mathbb{C}`), " であり、", math(String.raw`g`), " は ", math(String.raw`W`), " 上の線型形式なので ",
        math(String.raw`g(w_k)\in\mathbb{C}`), " である（", ref("def_dual_space"), "）。したがって右辺は ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元を一つ定める。双対基底 ", math(String.raw`f`), " との区別のため、", math(String.raw`W^{*}`), " の元には文字 ", math(String.raw`g`), " を使う。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_matrix_valued_map_on_split_quadratic_space_is_linear_map",
    kind: "claim",
    title: { text: "分裂した二次空間から行列環への写像は線型写像である" },
    labels: ["claim_matrix_valued_map_on_split_quadratic_space_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), " と ", math(String.raw`\varphi`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"), " のものとする。",
        math(String.raw`\varphi`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C}))`), "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"), "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "式を短くするため ", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置き、その演算を ", math(String.raw`+_B,\ \ast_B,\ 0_B`),
        " と書く（", ref("def_matrices_indexed_by_finite_set"), "）。証明の中だけで、", math(String.raw`y\in W`), " と ", math(String.raw`h\in W^{*}`),
        " について ", math(String.raw`C(y):=\sum_{k=1}^{M}\beta^{w}_k(y)\ast_B c_k`), "、", math(String.raw`D(h):=\sum_{k=1}^{M}h(w_k)\ast_B c_k^{\mathsf T}`),
        " と置く。", math(String.raw`\varphi((y,h))=C(y)+_B D(h)`), " である（", ref("def_matrix_valued_map_on_split_quadratic_space"), "）。",
        math(String.raw`(x,g),(x',g')\in V`), " と ", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
      ]),
      paragraph([
        "準備。", math(String.raw`\beta^{w}_k`), " は線型形式なので（", ref("claim_coordinate_map_is_linear_form"), "、", ref("def_linear_form"), "）、各 ",
        math(String.raw`k`), " で ", math(String.raw`\beta^{w}_k(x+_W x')\ast_B c_k=(\beta^{w}_k(x)+_{\mathbb{C}}\beta^{w}_k(x'))\ast_B c_k`), " と ",
        math(String.raw`\beta^{w}_k(\lambda\cdot_W x)\ast_B c_k=(\lambda\cdot_{\mathbb{C}}\beta^{w}_k(x))\ast_B c_k`), " が成り立つ。",
        math(String.raw`W^{*}`), " の演算の定義（", ref("def_dual_space"), "、", ref("claim_pointwise_sum_of_linear_forms_is_linear_form"), "、",
        ref("claim_pointwise_scalar_multiple_of_linear_form_is_linear_form"), "）により、各 ", math(String.raw`k`), " で ",
        math(String.raw`(g+_{W^{*}}g')(w_k)=g(w_k)+_{\mathbb{C}}g'(w_k)`), " と ", math(String.raw`(\lambda\cdot_{W^{*}}g)(w_k)=\lambda\cdot_{\mathbb{C}}g(w_k)`),
        " が成り立つ。これらを使って四つの等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
C(x+_W x')
&=\sum_{k=1}^{M}\bigl(\beta^{w}_k(x)+_{\mathbb{C}}\beta^{w}_k(x')\bigr)\ast_B c_k
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=C(x)+_B C(x')
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right),\\[4pt]
D(g+_{W^{*}}g')
&=\sum_{k=1}^{M}\bigl(g(w_k)+_{\mathbb{C}}g'(w_k)\bigr)\ast_B c_k^{\mathsf T}
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=D(g)+_B D(g')
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right),\\[4pt]
C(\lambda\cdot_W x)
&=\sum_{k=1}^{M}\bigl(\lambda\cdot_{\mathbb{C}}\beta^{w}_k(x)\bigr)\ast_B c_k
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda\ast_B C(x)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right),\\[4pt]
D(\lambda\cdot_{W^{*}}g)
&=\sum_{k=1}^{M}\bigl(\lambda\cdot_{\mathbb{C}}g(w_k)\bigr)\ast_B c_k^{\mathsf T}
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda\ast_B D(g)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "加法を保つこと。以下の加法の結合法則・交換法則は ", math(String.raw`U_{\mathrm{vec}}(B)`), " のもの（", ref("def_complex_vector_space"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\varphi\bigl((x,g)+_V(x',g')\bigr)\\
&\quad=\varphi\bigl((x+_W x',\ g+_{W^{*}}g')\bigr)
&&\left(\because\ \text{直和の加法の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=C(x+_W x')+_B D(g+_{W^{*}}g')
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&\quad=\bigl(C(x)+_B C(x')\bigr)+_B D(g+_{W^{*}}g')
&&\left(\because\ \text{準備の一つ目の等式}\right)\\
&\quad=\bigl(C(x)+_B C(x')\bigr)+_B\bigl(D(g)+_B D(g')\bigr)
&&\left(\because\ \text{準備の二つ目の等式}\right)\\
&\quad=C(x)+_B\Bigl(C(x')+_B\bigl(D(g)+_B D(g')\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=C(x)+_B\Bigl(\bigl(C(x')+_B D(g)\bigr)+_B D(g')\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=C(x)+_B\Bigl(\bigl(D(g)+_B C(x')\bigr)+_B D(g')\Bigr)
&&\left(\because\ \text{加法の交換法則}\right)\\
&\quad=C(x)+_B\Bigl(D(g)+_B\bigl(C(x')+_B D(g')\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=\bigl(C(x)+_B D(g)\bigr)+_B\bigl(C(x')+_B D(g')\bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=\varphi\bigl((x,g)\bigr)+_B\varphi\bigl((x',g')\bigr)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\varphi\bigl(\lambda\cdot_V(x,g)\bigr)
&=\varphi\bigl((\lambda\cdot_W x,\ \lambda\cdot_{W^{*}}g)\bigr)
&&\left(\because\ \text{直和のスカラー倍の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=C(\lambda\cdot_W x)+_B D(\lambda\cdot_{W^{*}}g)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=\bigl(\lambda\ast_B C(x)\bigr)+_B D(\lambda\cdot_{W^{*}}g)
&&\left(\because\ \text{準備の三つ目の等式}\right)\\
&=\bigl(\lambda\ast_B C(x)\bigr)+_B\bigl(\lambda\ast_B D(g)\bigr)
&&\left(\because\ \text{準備の四つ目の等式}\right)\\
&=\lambda\ast_B\bigl(C(x)+_B D(g)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_B\varphi\bigl((x,g)\bigr)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`\varphi`), " は線型写像である（", ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_matrix_valued_map_on_split_quadratic_space",
    kind: "claim",
    title: { text: "分裂した二次空間から行列環への写像の値の自分自身との積は、二次形式の値の単位行列倍である" },
    labels: ["claim_square_of_matrix_valued_map_on_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`\varphi`), " を ",
        ref("def_matrix_valued_map_on_split_quadratic_space"), " のものとする。すべての ", math(String.raw`v\in V`), " について、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " の中で次が成り立つ（演算と単位行列は ", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`\varphi(v)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\varphi(v)=q(v)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "式を短くするため ", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置き、その演算と単位元を ",
        math(String.raw`+_B,\ \cdot_B,\ \ast_B,\ 0_B,\ 1_B`), " と書く。", math(String.raw`B`), " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）。", math(String.raw`v=(x,g)`), "（", math(String.raw`x\in W`), "、",
        math(String.raw`g\in W^{*}`), "）と書き、", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`\lambda_k:=\beta^{w}_k(x)\in\mathbb{C}`), "、",
        math(String.raw`\mu_k:=g(w_k)\in\mathbb{C}`), "、", math(String.raw`C:=\sum_{k=1}^{M}\lambda_k\ast_B c_k`), "、", math(String.raw`D:=\sum_{k=1}^{M}\mu_k\ast_B c_k^{\mathsf T}`),
        " と置く。", math(String.raw`\varphi(v)=C+_B D`), " である（", ref("def_matrix_valued_map_on_split_quadratic_space"), "）。",
        math(String.raw`\delta_{k,l}\in\mathbb{C}`), " は ", math(String.raw`\{1,\dots,M\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
      ]),
      paragraph([
        "準備の一つ目。", math(String.raw`C\cdot_B C=0_B`), " である。", ref("claim_square_of_linear_combination_of_anticommuting_square_zero_elements_is_zero"),
        " を ", math(String.raw`A:=B`), "、", math(String.raw`n:=M`), "、", math(String.raw`p_k:=c_k`), " に当てる。一つ目の仮定は ",
        ref("claim_square_of_creation_operator_matrix_is_zero"), "、二つ目の仮定は ", ref("claim_creation_operator_matrices_anticommute"), " である。",
      ]),
      paragraph([
        "準備の二つ目。", math(String.raw`D\cdot_B D=0_B`), " である。同じ主張を ", math(String.raw`p_k:=c_k^{\mathsf T}`), "、係数 ", math(String.raw`\mu_k`),
        " に当てる。一つ目の仮定は ", ref("claim_square_of_annihilation_operator_matrix_is_zero"), "、二つ目の仮定は ",
        ref("claim_annihilation_operator_matrices_anticommute"), " である。",
      ]),
      paragraph([
        "準備の三つ目。各 ", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`c_k\cdot_B D+_B D\cdot_B c_k=\mu_k\ast_B 1_B`), " である。",
        "まず、各 ", math(String.raw`l\in\{1,\dots,M\}`), " について項の二つの等式を示す。以下のスカラー倍の結合法則は ", math(String.raw`U_{\mathrm{vec}}(B)`),
        " のもの（", ref("def_complex_vector_space"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
c_l^{\mathsf T}\cdot_B c_k+_B c_k\cdot_B c_l^{\mathsf T}
&=c_k\cdot_B c_l^{\mathsf T}+_B c_l^{\mathsf T}\cdot_B c_k
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{k,l}\ast_B 1_B
&&\left(\because\ i:=k\text{、}j:=l\text{。}\blkref{claim_creation_and_annihilation_operator_matrices_anticommute}\right),\\[4pt]
\mu_l\ast_B(\delta_{k,l}\ast_B 1_B)
&=(\mu_l\cdot_{\mathbb{C}}\delta_{k,l})\ast_B 1_B
&&\left(\because\ \text{スカラー倍の結合法則}\right)\\
&=(\delta_{k,l}\cdot_{\mathbb{C}}\mu_l)\ast_B 1_B
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{k,l}\ast_B(\mu_l\ast_B 1_B)
&&\left(\because\ \text{スカラー倍の結合法則}\right)\\
&=\delta_{l,k}\ast_B(\mu_l\ast_B 1_B)
&&\left(\because\ k=l\ \text{と}\ l=k\ \text{は同値なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_k\cdot_B D+_B D\cdot_B c_k
&=D\cdot_B c_k+_B c_k\cdot_B D
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\sum_{l=1}^{M}\mu_l\ast_B\bigl(c_l^{\mathsf T}\cdot_B c_k+_B c_k\cdot_B c_l^{\mathsf T}\bigr)
&&\left(\because\ A:=B\text{、}n:=M\text{、}r_l:=c_l^{\mathsf T}\text{、}a:=c_k\text{。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=\sum_{l=1}^{M}\mu_l\ast_B\bigl(\delta_{k,l}\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で項の一つ目の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{l=1}^{M}\delta_{l,k}\ast_B\bigl(\mu_l\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で項の二つ目の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\mu_k\ast_B 1_B
&&\left(\because\ b_l:=\mu_l\ast_B 1_B\text{、}j:=k\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right).
\end{aligned}`),
      paragraph(["準備の四つ目。", math(String.raw`C\cdot_B D+_B D\cdot_B C=\sum_{k=1}^{M}\lambda_k\ast_B(\mu_k\ast_B 1_B)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
C\cdot_B D+_B D\cdot_B C
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(c_k\cdot_B D+_B D\cdot_B c_k\bigr)
&&\left(\because\ A:=B\text{、}n:=M\text{、}r_k:=c_k\text{、}\mu:=\lambda\text{、}a:=D\text{。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で準備の三つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right).
\end{aligned}`),
      paragraph([
        "準備の五つ目。", math(String.raw`g(x)\ast_B 1_B=\sum_{k=1}^{M}\lambda_k\ast_B(\mu_k\ast_B 1_B)`), " である。写像 ", math(String.raw`h:W\to B`), " を ",
        math(String.raw`h(y):=g(y)\ast_B 1_B`), " で定める。", math(String.raw`h`), " は ", math(String.raw`W`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`),
        " への線型写像である。実際、", math(String.raw`y,y'\in W`), "、", math(String.raw`\rho\in\mathbb{C}`), " について次が成り立つ（", math(String.raw`g`),
        " は線型形式。", ref("def_dual_space"), "、", ref("def_linear_form"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
h(y+_W y')
&=g(y+_W y')\ast_B 1_B
&&\left(\because\ h\ \text{の定義}\right)\\
&=\bigl(g(y)+_{\mathbb{C}}g(y')\bigr)\ast_B 1_B
&&\left(\because\ g\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=g(y)\ast_B 1_B+_B g(y')\ast_B 1_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h(y)+_B h(y')
&&\left(\because\ h\ \text{の定義を二か所に適用}\right),\\[4pt]
h(\rho\cdot_W y)
&=g(\rho\cdot_W y)\ast_B 1_B
&&\left(\because\ h\ \text{の定義}\right)\\
&=\bigl(\rho\cdot_{\mathbb{C}}g(y)\bigr)\ast_B 1_B
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\rho\ast_B\bigl(g(y)\ast_B 1_B\bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\rho\ast_B h(y)
&&\left(\because\ h\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g(x)\ast_B 1_B
&=h(x)
&&\left(\because\ h\ \text{の定義}\right)\\
&=h\left(\sum_{k=1}^{M}\beta^{w}_k(x)\cdot_W w_k\right)
&&\left(\because\ \text{座標の写像の定め方。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_B h(w_k)
&&\left(\because\ f:=h\text{。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \lambda_k\text{、}\mu_k\text{、}h\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "本題。以下の分配法則・加法の結合法則・交換法則・単位元は ", math(String.raw`U_{\mathrm{ring}}(B)`), " のもの（", ref("def_unital_ring"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(v)\cdot_B\varphi(v)
&=(C+_B D)\cdot_B(C+_B D)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=C\cdot_B(C+_B D)+_B D\cdot_B(C+_B D)
&&\left(\because\ \text{分配法則（左の因子の和）}\right)\\
&=\bigl(C\cdot_B C+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B D\cdot_B D\bigr)
&&\left(\because\ \text{分配法則（右の因子の和）を二か所に適用}\right)\\
&=\bigl(0_B+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B D\cdot_B D\bigr)
&&\left(\because\ \text{準備の一つ目}\right)\\
&=\bigl(0_B+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B 0_B\bigr)
&&\left(\because\ \text{準備の二つ目}\right)\\
&=\bigl(C\cdot_B D+_B 0_B\bigr)+_B\bigl(D\cdot_B C+_B 0_B\bigr)
&&\left(\because\ \text{加法の交換法則}\right)\\
&=C\cdot_B D+_B D\cdot_B C
&&\left(\because\ \text{加法の単位元を二か所に適用}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \text{準備の四つ目}\right)\\
&=g(x)\ast_B 1_B
&&\left(\because\ \text{準備の五つ目}\right)\\
&=q_W\bigl((x,g)\bigr)\ast_B 1_B
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=q(v)\ast_B 1_B
&&\left(\because\ q:=q_W\text{、}v=(x,g)\text{。}\blkref{def_clifford_algebra_of_split_quadratic_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra",
    kind: "claim",
    title: { text: "クリフォード代数から行列環への準同型の存在と一意性" },
    labels: ["claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), " を ",
        ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`\varphi`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"),
        " のものとする。", math(String.raw`\mathrm{Cl}(V,q)`), " から ℂ-代数 ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）で、",
        math(String.raw`V`), " から ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " への写像として ", math(String.raw`\Phi\circ\gamma=\varphi`),
        " を満たすもの ", math(String.raw`\Phi`), " が、ただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "クリフォード代数の普遍性（", ref("claim_universal_property_of_clifford_algebra"), "）を、", math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、", math(String.raw`f:=\varphi`), " に当てる。", math(String.raw`A`), " は ℂ-代数であり（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "）、", math(String.raw`\varphi`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像であり（",
        ref("claim_matrix_valued_map_on_split_quadratic_space_is_linear_map"), "）、すべての ", math(String.raw`v\in V`), " について ",
        math(String.raw`\varphi(v)\cdot_A\varphi(v)=q(v)\ast_A 1_A`), " が成り立つ（", ref("claim_square_of_matrix_valued_map_on_split_quadratic_space"),
        "）。普遍性の仮定がすべて満たされたので、", math(String.raw`\Phi\circ\gamma=\varphi`), " を満たす ℂ-代数の準同型 ", math(String.raw`\Phi`),
        " がただ一つ存在する。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_clifford_algebra_to_matrix_algebra",
    kind: "definition",
    title: { text: "クリフォード代数から行列環への準同型" },
    labels: ["def_homomorphism_from_clifford_algebra_to_matrix_algebra"],
    statement: [
      paragraph([
        ref("claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra"), " のただ一つの ℂ-代数の準同型を ",
        math(String.raw`\Phi:\mathrm{Cl}(V,q)\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。", math(String.raw`\Phi`), " は ",
        math(String.raw`\Phi\circ\gamma=\varphi`), " を満たす。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix",
    kind: "claim",
    title: { text: "行列環への準同型は、生成作用素にあたる元を生成作用素の行列へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`a^{\dagger}_i`), " を ",
        ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi\bigl(a^{\dagger}_i\bigr)=c_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。準備として、各 ", math(String.raw`k\in\{1,\dots,M\}`), " について項の二つの等式を示す。",
        math(String.raw`z_W`), " は ", ref("claim_zero_map_is_linear_form"), " の零写像である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\beta^{w}_k(w_i)\ast_B c_k
&=\delta_{k,i}\ast_B c_k
&&\left(\because\ \text{座標の写像の族は双対基底。}\blkref{claim_coordinate_maps_form_dual_basis}\right),\\[4pt]
0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}
&=z_W(w_k)\ast_B c_k^{\mathsf T}
&&\left(\because\ 0_{W^{*}}:=z_W\text{。}\blkref{def_dual_space}\right)\\
&=0_{\mathbb{C}}\ast_B c_k^{\mathsf T}
&&\left(\because\ z_W\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(a^{\dagger}_i\bigr)
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_1(w_i)\bigr)\Bigr)
&&\left(\because\ \blkref{def_creation_generator_of_split_clifford_algebra}\right)\\
&=\varphi\bigl(\mathrm{in}_1(w_i)\bigr)
&&\left(\because\ \Phi\circ\gamma=\varphi\text{。}\blkref{def_homomorphism_from_clifford_algebra_to_matrix_algebra}\right)\\
&=\varphi\bigl((w_i,\ 0_{W^{*}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(w_i)\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=\left(\sum_{k=1}^{M}\delta_{k,i}\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の一つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=c_i+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ b_k:=c_k\text{、}j:=i\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=c_i+_B 0_B
&&\left(\because\ \text{各項で準備の二つ目。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right)\\
&=c_i
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix",
    kind: "claim",
    title: { text: "行列環への準同型は、消滅作用素にあたる元を消滅作用素の行列へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi(a_i)=c_i^{\mathsf T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。準備として、各 ", math(String.raw`k\in\{1,\dots,M\}`), " について項の二つの等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\beta^{w}_k(0_W)\ast_B c_k
&=0_{\mathbb{C}}\ast_B c_k
&&\left(\because\ \beta^{w}_k\ \text{は線型形式。}\blkref{claim_coordinate_map_is_linear_form}\text{、}\blkref{claim_linear_form_sends_zero_vector_to_zero}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right),\\[4pt]
f_i(w_k)\ast_B c_k^{\mathsf T}
&=\delta_{i,k}\ast_B c_k^{\mathsf T}
&&\left(\because\ f\ \text{は}\ w\ \text{の双対基底。}\blkref{def_dual_basis}\right)\\
&=\delta_{k,i}\ast_B c_k^{\mathsf T}
&&\left(\because\ i=k\ \text{と}\ k=i\ \text{は同値なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi(a_i)
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_2(f_i)\bigr)\Bigr)
&&\left(\because\ \blkref{def_annihilation_generator_of_split_clifford_algebra}\right)\\
&=\varphi\bigl(\mathrm{in}_2(f_i)\bigr)
&&\left(\because\ \Phi\circ\gamma=\varphi\text{。}\blkref{def_homomorphism_from_clifford_algebra_to_matrix_algebra}\right)\\
&=\varphi\bigl((0_W,\ f_i)\bigr)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(0_W)\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}f_i(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=0_B+_B\left(\sum_{k=1}^{M}f_i(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の一つ目。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right)\\
&=0_B+_B\left(\sum_{k=1}^{M}\delta_{k,i}\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の二つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=0_B+_B c_i^{\mathsf T}
&&\left(\because\ b_k:=c_k^{\mathsf T}\text{、}j:=i\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=c_i^{\mathsf T}+_B 0_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=c_i^{\mathsf T}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_local_identities_in_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数の中の局所的な等式" },
    labels: [],
  },
  {
    id: "isomorphism_definition_ordered_product_of_selected_creation_generators",
    kind: "definition",
    title: { text: "部分集合の元の番号の生成作用素にあたる元の番号順の積" },
    labels: ["def_ordered_product_of_selected_creation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_t`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`S\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元 ", math(String.raw`y^{S}_t`), " を、", math(String.raw`t\in S`), " なら ", math(String.raw`y^{S}_t:=a^{\dagger}_t`), "、", math(String.raw`t\notin S`),
        " なら ", math(String.raw`y^{S}_t:=1_{\mathrm{Cl}(V,q)}`), " と定める（", math(String.raw`t\in S`), " の真偽は ", ref("def_power_set_of_first_m_positive_integers"),
        " により一つに決まる）。", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ", math(String.raw`a^{\dagger}_S`), " を、ℂ-代数 ", math(String.raw`\mathrm{Cl}(V,q)`),
        "（", ref("def_clifford_algebra"), "）の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`a^{\dagger}_S:=\prod_{\mathrm{Cl}(V,q),\,t=1}^{M}y^{S}_t`),
      paragraph([
        "記号 ", math(String.raw`a^{\dagger}_S`), " の下付きは ", math(String.raw`\mathcal{P}_M`), " の元であり、", math(String.raw`\{1,\dots,M\}`),
        " の元を下付きにした ", math(String.raw`a^{\dagger}_i`), " とは別の記号である。", math(String.raw`a^{\dagger}_S`), " は、",
        math(String.raw`S`), " の元 ", math(String.raw`t`), " の ", math(String.raw`a^{\dagger}_t`), " を、", math(String.raw`t`),
        " の小さい順に左から右へ掛けた積である。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_reverse_ordered_product_of_selected_annihilation_generators",
    kind: "definition",
    title: { text: "部分集合の元の番号の消滅作用素にあたる元の、番号の逆順の積" },
    labels: ["def_reverse_ordered_product_of_selected_annihilation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_t`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元 ", math(String.raw`z^{T}_t`), " を、", math(String.raw`t\in T`), " なら ", math(String.raw`z^{T}_t:=a_t`), "、", math(String.raw`t\notin T`),
        " なら ", math(String.raw`z^{T}_t:=1_{\mathrm{Cl}(V,q)}`), " と定める。", math(String.raw`k\in\{1,\dots,M\}`), " について ",
        math(String.raw`M+1-k\in\{1,\dots,M\}`), " なので、番号を逆順に並べ直した族 ", math(String.raw`w^{T}_k:=z^{T}_{M+1-k}`), " が定まる。",
        math(String.raw`\mathrm{Cl}(V,q)`), " の元 ", math(String.raw`a_T`), " を、ℂ-代数 ", math(String.raw`\mathrm{Cl}(V,q)`), "（", ref("def_clifford_algebra"),
        "）の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`a_T:=\prod_{\mathrm{Cl}(V,q),\,k=1}^{M}w^{T}_k`),
      paragraph([
        math(String.raw`a_T`), " は ", math(String.raw`z^{T}_M,\dots,z^{T}_1`), " をこの順に左から右へ掛けた積、すなわち ", math(String.raw`T`),
        " の元 ", math(String.raw`t`), " の ", math(String.raw`a_t`), " を ", math(String.raw`t`), " の大きい順に左から右へ掛けた積である。記号 ",
        math(String.raw`a_T`), " の下付きは ", math(String.raw`\mathcal{P}_M`), " の元であり、", math(String.raw`a_i`), "（", math(String.raw`i\in\{1,\dots,M\}`),
        "）とは別の記号である。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_vacuum_element_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "真空への射影にあたる元" },
    labels: ["def_vacuum_element_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\in\{1,\dots,M\}`), " について ",
        math(String.raw`x_i:=a_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i\in\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ",
        math(String.raw`P`), " を、ℂ-代数 ", math(String.raw`\mathrm{Cl}(V,q)`), "（", ref("def_clifford_algebra"), "）の中の番号順の積（",
        ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`P:=\prod_{\mathrm{Cl}(V,q),\,i=1}^{M}x_i`),
      paragraph([math(String.raw`P`), " を真空への射影にあたる元と呼ぶ。"]),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_generator_commutes_with_other_number_pair",
    kind: "claim",
    title: { text: "消滅作用素にあたる元は、番号の違う消滅と生成の積と交換する" },
    labels: ["claim_annihilation_generator_commutes_with_other_number_pair"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_j`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq j`), " であるすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_i\cdot_{\mathrm{Cl}(V,q)}\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)=\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)\cdot_{\mathrm{Cl}(V,q)}a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"),
        " のものである。準備として、", math(String.raw`i\neq j`), " なので ", math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A a^{\dagger}_j+_A a^{\dagger}_j\cdot_A a_i
&=\delta_{i,j}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ i\neq j\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A\bigl(a_j\cdot_A a^{\dagger}_j\bigr)
&=\bigl(a_i\cdot_A a_j\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ p:=a_i\text{、}q:=a_j\text{。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a_j\cdot_A a_i)\cdot_A a^{\dagger}_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a_i\cdot_A a^{\dagger}_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ p:=a_i\text{、}q:=a^{\dagger}_j\text{。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a_j\cdot_A a^{\dagger}_j\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_commutes_with_other_number_pair",
    kind: "claim",
    title: { text: "生成作用素にあたる元は、番号の違う消滅と生成の積と交換する" },
    labels: ["claim_creation_generator_commutes_with_other_number_pair"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_j`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq j`), " であるすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)=\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"),
        " のものである。準備として、", math(String.raw`j\neq i`), " なので ", math(String.raw`\delta_{j,i}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a_j+_A a_j\cdot_A a^{\dagger}_i
&=a_j\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A a_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\delta_{j,i}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\ \text{の}\ i,j\ \text{に}\ j,i\ \text{を当てる}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ j\neq i\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\bigl(a_j\cdot_A a^{\dagger}_j\bigr)
&=\bigl(a^{\dagger}_i\cdot_A a_j\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a^{\dagger}_i)\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ p:=a^{\dagger}_i\text{、}q:=a_j\text{。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a_j\cdot_A a^{\dagger}_i)\cdot_A a^{\dagger}_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ p:=a^{\dagger}_i\text{、}q:=a^{\dagger}_j\text{。}\blkref{claim_creation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a_j\cdot_A a^{\dagger}_j\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_generator_times_vacuum_element_is_zero",
    kind: "claim",
    title: { text: "消滅作用素にあたる元を真空への射影にあたる元に左から掛けると零になる" },
    labels: ["claim_annihilation_generator_times_vacuum_element_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`P`), " を真空への射影にあたる元（",
        ref("def_vacuum_element_of_split_clifford_algebra"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_i\cdot_{\mathrm{Cl}(V,q)}P=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`x_j:=a_j\cdot_A a^{\dagger}_j`), "（", math(String.raw`j\in\{1,\dots,M\}`), "）を ",
        ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`L:=\prod_{A,\,j=1}^{i-1}x_j`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}x_{i+r}`), " と置く（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      paragraph([
        "準備。", math(String.raw`j\in\{1,\dots,i-1\}`), " なら ", math(String.raw`j\neq i`), " なので ", math(String.raw`a_i\cdot_A x_j=x_j\cdot_A a_i`), " である（",
        ref("claim_annihilation_generator_commutes_with_other_number_pair"), "）。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"),
        " を ", math(String.raw`u:=a_i`), "、", math(String.raw`n:=i-1`), "、族 ", math(String.raw`x_1,\dots,x_{i-1}`), " に当てて、",
        math(String.raw`a_i\cdot_A L=L\cdot_A a_i`), " が成り立つ。積 ", math(String.raw`0_A\cdot_A y`), " と ", math(String.raw`y\cdot_A 0_A`), "（",
        math(String.raw`y\in A`), "）が ", math(String.raw`0_A`), " であることは、右から ", math(String.raw`y`), " を掛ける写像と左から ", math(String.raw`y`),
        " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"),
        "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A P
&=a_i\cdot_A\Bigl(L\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_vacuum_element_of_split_clifford_algebra}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\bigl(a_i\cdot_A L\bigr)\cdot_A\bigl(x_i\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(L\cdot_A a_i\bigr)\cdot_A\bigl(x_i\cdot_A R\bigr)
&&\left(\because\ \text{準備}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A x_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A(a_i\cdot_A a^{\dagger}_i)\bigr)\cdot_A R\Bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=L\cdot_A\Bigl(\bigl((a_i\cdot_A a_i)\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(0_A\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=L\cdot_A\bigl(0_A\cdot_A R\bigr)
&&\left(\because\ \text{準備（右から}\ a^{\dagger}_i\ \text{を掛ける写像）}\right)\\
&=L\cdot_A 0_A
&&\left(\because\ \text{準備（右から}\ R\ \text{を掛ける写像）}\right)\\
&=0_A
&&\left(\because\ \text{準備（左から}\ L\ \text{を掛ける写像）}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_element_times_creation_generator_is_zero",
    kind: "claim",
    title: { text: "真空への射影にあたる元に生成作用素にあたる元を右から掛けると零になる" },
    labels: ["claim_vacuum_element_times_creation_generator_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`P`), " を真空への射影にあたる元（",
        ref("def_vacuum_element_of_split_clifford_algebra"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`P\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`x_j:=a_j\cdot_A a^{\dagger}_j`), "（", math(String.raw`j\in\{1,\dots,M\}`), "）を ",
        ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`L:=\prod_{A,\,j=1}^{i-1}x_j`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}x_{i+r}`), " と置く（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      paragraph([
        "準備。", math(String.raw`r\in\{1,\dots,M-i\}`), " なら ", math(String.raw`i+r\neq i`), " なので ", math(String.raw`a^{\dagger}_i\cdot_A x_{i+r}=x_{i+r}\cdot_A a^{\dagger}_i`),
        " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`j`), " に ", math(String.raw`i+r`), " を当てる）。したがって ",
        ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=a^{\dagger}_i`), "、", math(String.raw`n:=M-i`),
        "、族 ", math(String.raw`r\mapsto x_{i+r}`), " に当てて、", math(String.raw`a^{\dagger}_i\cdot_A R=R\cdot_A a^{\dagger}_i`), " が成り立つ。積 ",
        math(String.raw`0_A\cdot_A y`), " と ", math(String.raw`y\cdot_A 0_A`), "（", math(String.raw`y\in A`), "）が ", math(String.raw`0_A`),
        " であることは、右から ", math(String.raw`y`), " を掛ける写像と左から ", math(String.raw`y`), " を掛ける写像が線型写像であり（",
        ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "）、線型写像は零を零へ移すこと（",
        ref("claim_linear_map_sends_zero_to_zero"), "）による。",
      ]),
      displayMath(String.raw`\begin{aligned}
P\cdot_A a^{\dagger}_i
&=\Bigl(L\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_vacuum_element_of_split_clifford_algebra}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=L\cdot_A\Bigl(\bigl(x_i\cdot_A R\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(x_i\cdot_A\bigl(R\cdot_A a^{\dagger}_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(x_i\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{準備}\right)\\
&=L\cdot_A\Bigl(\bigl(x_i\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl((a_i\cdot_A a^{\dagger}_i)\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_i)\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A 0_A\bigr)\cdot_A R\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=L\cdot_A\bigl(0_A\cdot_A R\bigr)
&&\left(\because\ \text{準備（左から}\ a_i\ \text{を掛ける写像）}\right)\\
&=L\cdot_A 0_A
&&\left(\because\ \text{準備（右から}\ R\ \text{を掛ける写像）}\right)\\
&=0_A
&&\left(\because\ \text{準備（左から}\ L\ \text{を掛ける写像）}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_passes_initial_creation_factors_with_sign",
    kind: "claim",
    title: { text: "生成作用素にあたる元を、番号の小さい側の生成の因子の積の右へ移すと、番号より小さい元の個数の符号が付く" },
    labels: ["claim_creation_generator_passes_initial_creation_factors_with_sign"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " とする。", math(String.raw`y^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ",
        ref("def_ordered_product_of_selected_creation_generators"), " のもの、", math(String.raw`N_{m}(T)`), " を ", ref("def_count_of_subset_elements_below_index"),
        "、", math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,i-1\}`),
        " について、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ（",
        math(String.raw`m+1\le i\le M`), " なので ", math(String.raw`N_{m+1}(T)`), " は定まる）。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}\prod_{\mathrm{Cl}(V,q),\,t=1}^{m}y^{T}_t=\varsigma\bigl(N_{m+1}(T)\bigr)\ast_{\mathrm{Cl}(V,q)}\left(\Bigl(\prod_{\mathrm{Cl}(V,q),\,t=1}^{m}y^{T}_t\Bigr)\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i\right)`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`y_t:=y^{T}_t`), "、", math(String.raw`N_m:=N_m(T)`), " と置き、", math(String.raw`\Pi_m`), "（",
        math(String.raw`m\in\{0,1,\dots,M\}`), "）を ", ref("def_ordered_product_in_algebra"), " の部分積とする（", math(String.raw`\Pi_0=1_A`), "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A y_m`), "）。部分積の式は番号 ", math(String.raw`m`), " までの因子だけで定まるので、", math(String.raw`\Pi_m`),
        " は族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積と同じ元である。", math(String.raw`-1_{\mathbb{C}}`), " は ",
        ref("claim_anticommuting_elements_swap_with_sign"), " のものである。主張を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_0
&=a^{\dagger}_i\cdot_A 1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(0)\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_1)\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_1)\ast_A\bigl(\Pi_0\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le i-1`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`m\le i-1\le M-1`),
        " なので ", math(String.raw`m+1\in\{2,\dots,M\}`), " であり、", math(String.raw`N_{m+1}`), " は ", ref("def_count_of_subset_elements_below_index"),
        " の二つ目の式で定まる。また ", math(String.raw`m\neq i`), " である。", math(String.raw`m\in T`), " のとき、", math(String.raw`y_m=a^{\dagger}_m`),
        " であり（", ref("def_ordered_product_of_selected_creation_generators"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_m
&=a^{\dagger}_i\cdot_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=a^{\dagger}_m\right)\\
&=\bigl(a^{\dagger}_i\cdot_A\Pi_{m-1}\bigr)\cdot_A a^{\dagger}_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma(N_m)\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A a^{\dagger}_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)\cdot_A a^{\dagger}_m\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\Pi_{m-1}\cdot_A\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_m\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\Pi_{m-1}\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ p:=a^{\dagger}_i\text{、}q:=a^{\dagger}_m\text{。}\blkref{claim_creation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=\varsigma(N_m)\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(\varsigma(N_m)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_m)\bigr)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\varsigma(N_m+1)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ m\in T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((\Pi_{m-1}\cdot_A a^{\dagger}_m)\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_m\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=a^{\dagger}_m\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\notin T`), " のとき、", math(String.raw`y_m=1_A`), " であり（", ref("def_ordered_product_of_selected_creation_generators"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_m
&=a^{\dagger}_i\cdot_A\bigl(\Pi_{m-1}\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=1_A\right)\\
&=a^{\dagger}_i\cdot_A\Pi_{m-1}
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ m\notin T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((\Pi_{m-1}\cdot_A 1_A)\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_m\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=1_A\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_ordered_creation_product_without_index",
    kind: "claim",
    title: { text: "番号を含まない部分集合の生成の積に、その番号の生成作用素にあたる元を左から掛けると、番号を足した部分集合の生成の積の符号倍になる" },
    labels: ["claim_creation_generator_times_ordered_creation_product_without_index"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a^{\dagger}_T`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), " の元、", math(String.raw`N_i(T)`), " を ", ref("def_count_of_subset_elements_below_index"), "、",
        math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " が ", math(String.raw`i\notin T`), " を満たすとき、", math(String.raw`T\cup\{i\}\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_T=\varsigma\bigl(N_i(T)\bigr)\ast_{\mathrm{Cl}(V,q)}a^{\dagger}_{T\cup\{i\}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`S:=T\cup\{i\}`), " と置く。", math(String.raw`t\in\{1,\dots,M\}`), " が ", math(String.raw`t\neq i`),
        " なら ", math(String.raw`t\in S`), " と ", math(String.raw`t\in T`), " は同値なので、", math(String.raw`y^{S}_t=y^{T}_t`), " である（",
        ref("def_ordered_product_of_selected_creation_generators"), "）。また ", math(String.raw`i\notin T`), " なので ", math(String.raw`y^{T}_i=1_A`), "、",
        math(String.raw`i\in S`), " なので ", math(String.raw`y^{S}_i=a^{\dagger}_i`), " である。", math(String.raw`L:=\prod_{A,\,t=1}^{i-1}y^{T}_t`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}y^{T}_{i+r}`), " と置く。", math(String.raw`t\le i-1`), " と ", math(String.raw`i+r\ge i+1`),
        " の番号では二つの族の値が等しいので、族 ", math(String.raw`y^{S}`), " で同じ式を作っても同じ族の番号順の積であり、", math(String.raw`L=\prod_{A,\,t=1}^{i-1}y^{S}_t`),
        "、", math(String.raw`R=\prod_{A,\,r=1}^{M-i}y^{S}_{i+r}`), " である（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a^{\dagger}_T
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(y^{T}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(1_A\cdot_A R\bigr)\Bigr)
&&\left(\because\ y^{T}_i=1_A\right)\\
&=a^{\dagger}_i\cdot_A\bigl(L\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A L\bigr)\cdot_A R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A R
&&\left(\because\ m:=i-1\text{。}\blkref{claim_creation_generator_passes_initial_creation_factors_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(\bigl(L\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(y^{S}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ y^{S}_i=a^{\dagger}_i\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\prod_{A,\,t=1}^{M}y^{S}_t
&&\left(\because\ \text{族}\ y^{S}\ \text{に}\ n:=M\text{、}p:=i\ \text{で当てる。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A a^{\dagger}_{T\cup\{i\}}
&&\left(\because\ S=T\cup\{i\}\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_ordered_creation_product_with_index_is_zero",
    kind: "claim",
    title: { text: "番号を含む部分集合の生成の積に、その番号の生成作用素にあたる元を左から掛けると零になる" },
    labels: ["claim_creation_generator_times_ordered_creation_product_with_index_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a^{\dagger}_T`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), " の元とする。", math(String.raw`T\in\mathcal{P}_M`), "、", math(String.raw`i\in\{1,\dots,M\}`),
        " が ", math(String.raw`i\in T`), " を満たすとき、次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_T=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`L:=\prod_{A,\,t=1}^{i-1}y^{T}_t`), "、", math(String.raw`R:=\prod_{A,\,r=1}^{M-i}y^{T}_{i+r}`),
        " と置く（", ref("def_ordered_product_of_selected_creation_generators"), "）。", math(String.raw`i\in T`), " なので ", math(String.raw`y^{T}_i=a^{\dagger}_i`),
        " である。", math(String.raw`\varsigma`), " と ", math(String.raw`N_i(T)`), " は ", ref("claim_creation_generator_passes_initial_creation_factors_with_sign"),
        " のものである。積 ", math(String.raw`0_A\cdot_A y`), " と ", math(String.raw`y\cdot_A 0_A`), "（", math(String.raw`y\in A`), "）が ", math(String.raw`0_A`),
        " であることは、", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_linear_map_sends_zero_to_zero"), " による。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a^{\dagger}_T
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{、}y^{T}_i=a^{\dagger}_i\text{。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A L\bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_creation_generator_passes_initial_creation_factors_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(\bigl(L\cdot_A a^{\dagger}_i\bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A(a^{\dagger}_i\cdot_A R)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl((a^{\dagger}_i\cdot_A a^{\dagger}_i)\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(0_A\cdot_A R\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A 0_A\bigr)
&&\left(\because\ \text{右から}\ R\ \text{を掛ける写像は線型}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A 0_A
&&\left(\because\ \text{左から}\ L\ \text{を掛ける写像は線型}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_annihilation_factors_pass_annihilation_generator_with_sign",
    kind: "claim",
    title: { text: "番号の小さい側の消滅の因子の逆順の積の右から消滅作用素にあたる元を左へ移すと、番号より小さい元の個数の符号が付く" },
    labels: ["claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " とする。", math(String.raw`z^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの、", math(String.raw`N_{m}(T)`), " を ", ref("def_count_of_subset_elements_below_index"),
        "、", math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。", math(String.raw`m\in\{0,1,\dots,i-1\}`), " について、",
        math(String.raw`k\in\{1,\dots,m\}`), " に ", math(String.raw`z^{T}_{m+1-k}`), " を与える族の番号順の積（", ref("def_ordered_product_in_algebra"), "）を",
      ]),
      displayMath(String.raw`Q_m:=\prod_{\mathrm{Cl}(V,q),\,k=1}^{m}z^{T}_{m+1-k}`),
      paragraph([
        "と置く（", math(String.raw`z^{T}_m,\dots,z^{T}_1`), " をこの順に掛けた積である）。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,i-1\}`), " について次が成り立つ（",
        math(String.raw`m+1\le i\le M`), " なので ", math(String.raw`N_{m+1}(T)`), " は定まる）。",
      ]),
      displayMath(String.raw`Q_m\cdot_{\mathrm{Cl}(V,q)}a_i=\varsigma\bigl(N_{m+1}(T)\bigr)\ast_{\mathrm{Cl}(V,q)}\bigl(a_i\cdot_{\mathrm{Cl}(V,q)}Q_m\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`z_t:=z^{T}_t`), "、", math(String.raw`N_m:=N_m(T)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`),
        " は ", ref("claim_anticommuting_elements_swap_with_sign"), " のものである。",
      ]),
      paragraph([
        "準備。", math(String.raw`1\le m\le i-1`), " のとき ", math(String.raw`Q_m=z_m\cdot_A Q_{m-1}`), " である。実際、", math(String.raw`u_k:=z_{m+1-k}`),
        "（", math(String.raw`k\in\{1,\dots,m\}`), "）と置くと、", math(String.raw`u_1=z_m`), " であり、", math(String.raw`r\in\{1,\dots,m-1\}`), " について ",
        math(String.raw`u_{1+r}=z_{m-r}=z_{(m-1)+1-r}`), " なので、族 ", math(String.raw`r\mapsto u_{1+r}`), " は ", math(String.raw`Q_{m-1}`), " の族である。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_m
&=\left(\prod_{A,\,k=1}^{0}u_k\right)\cdot_A\left(u_1\cdot_A\prod_{A,\,r=1}^{m-1}u_{1+r}\right)
&&\left(\because\ n:=m\text{、}p:=1\text{。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=1_A\cdot_A\bigl(z_m\cdot_A Q_{m-1}\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}u_1=z_m\right)\\
&=z_m\cdot_A Q_{m-1}
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["本題。主張を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき：", ]),
      displayMath(String.raw`\begin{aligned}
Q_0\cdot_A a_i
&=1_A\cdot_A a_i
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_A a_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(0)\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_1)\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_1)\ast_A\bigl(a_i\cdot_A Q_0\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le i-1`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`m+1\in\{2,\dots,M\}`),
        " なので ", math(String.raw`N_{m+1}`), " は ", ref("def_count_of_subset_elements_below_index"), " の二つ目の式で定まる。", math(String.raw`m\in T`),
        " のとき、", math(String.raw`z_m=a_m`), " であり（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_m\cdot_A a_i
&=\bigl(a_m\cdot_A Q_{m-1}\bigr)\cdot_A a_i
&&\left(\because\ \text{準備}\text{、}z_m=a_m\right)\\
&=a_m\cdot_A\bigl(Q_{m-1}\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\varsigma(N_m)\ast_A\bigl(a_i\cdot_A Q_{m-1}\bigr)\Bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(a_m\cdot_A\bigl(a_i\cdot_A Q_{m-1}\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl(a_m\cdot_A a_i\bigr)\cdot_A Q_{m-1}\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A(a_i\cdot_A a_m)\bigr)\cdot_A Q_{m-1}\Bigr)
&&\left(\because\ p:=a_m\text{、}q:=a_i\text{。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=\varsigma(N_m)\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl((a_i\cdot_A a_m)\cdot_A Q_{m-1}\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(\varsigma(N_m)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A Q_{m-1}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_m)\bigr)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A Q_{m-1}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\varsigma(N_m+1)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A Q_{m-1}\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((a_i\cdot_A a_m)\cdot_A Q_{m-1}\bigr)
&&\left(\because\ m\in T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A(a_m\cdot_A Q_{m-1})\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A Q_m\bigr)
&&\left(\because\ \text{準備}\text{、}z_m=a_m\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\notin T`), " のとき、", math(String.raw`z_m=1_A`), " であり（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_m\cdot_A a_i
&=\bigl(1_A\cdot_A Q_{m-1}\bigr)\cdot_A a_i
&&\left(\because\ \text{準備}\text{、}z_m=1_A\right)\\
&=Q_{m-1}\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\bigl(a_i\cdot_A Q_{m-1}\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A Q_{m-1}\bigr)
&&\left(\because\ m\notin T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A(1_A\cdot_A Q_{m-1})\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A Q_m\bigr)
&&\left(\because\ \text{準備}\text{、}z_m=1_A\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index",
    kind: "claim",
    title: { text: "番号を含まない部分集合の消滅の逆順の積に、その番号の消滅作用素にあたる元を右から掛けると、番号を足した部分集合の消滅の逆順の積の符号倍になる" },
    labels: ["claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a_T`), " を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " の元、", math(String.raw`N_i(T)`), " を ", ref("def_count_of_subset_elements_below_index"), "、",
        math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " が ", math(String.raw`i\notin T`), " を満たすとき、", math(String.raw`T\cup\{i\}\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_T\cdot_{\mathrm{Cl}(V,q)}a_i=\varsigma\bigl(N_i(T)\bigr)\ast_{\mathrm{Cl}(V,q)}a_{T\cup\{i\}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`S:=T\cup\{i\}`), "、", math(String.raw`p:=M+1-i\in\{1,\dots,M\}`), " と置く。", math(String.raw`p-1=M-i`),
        "、", math(String.raw`M-p=i-1`), " である。", math(String.raw`t\neq i`), " なら ", math(String.raw`z^{S}_t=z^{T}_t`), "、また ", math(String.raw`z^{T}_i=1_A`), "、",
        math(String.raw`z^{S}_i=a_i`), " である（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "）。", math(String.raw`w^{T}_p=z^{T}_i`),
        " であり、", math(String.raw`r\in\{1,\dots,i-1\}`), " について ", math(String.raw`w^{T}_{p+r}=z^{T}_{i-r}=z^{T}_{(i-1)+1-r}`), " である。",
        math(String.raw`L:=\prod_{A,\,k=1}^{M-i}w^{T}_k`), " と置き、", math(String.raw`Q:=Q_{i-1}`), " を ", ref("claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"),
        " のもの（", math(String.raw`r\in\{1,\dots,i-1\}`), " に ", math(String.raw`z^{T}_{(i-1)+1-r}`), " を与える族の積）とする。", math(String.raw`k\le M-i`),
        " なら ", math(String.raw`M+1-k\ge i+1`), "、", math(String.raw`r\ge 1`), " なら ", math(String.raw`i-r\le i-1`), " なので、族 ", math(String.raw`w^{S}`),
        " で同じ式を作っても同じ族の番号順の積であり、", math(String.raw`L=\prod_{A,\,k=1}^{M-i}w^{S}_k`), "、", math(String.raw`Q=\prod_{A,\,r=1}^{i-1}w^{S}_{p+r}`),
        " である（", ref("def_ordered_product_in_algebra"), "）。同様に ", math(String.raw`Q=\prod_{A,\,r=1}^{i-1}w^{T}_{p+r}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_T\cdot_A a_i
&=\Bigl(L\cdot_A\bigl(w^{T}_p\cdot_A Q\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ n:=M\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\Bigl(L\cdot_A\bigl(1_A\cdot_A Q\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ w^{T}_p=z^{T}_i=1_A\right)\\
&=\bigl(L\cdot_A Q\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\bigl(Q\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A Q\bigr)\Bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_initial_annihilation_factors_pass_annihilation_generator_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a_i\cdot_A Q\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(w^{S}_p\cdot_A Q\bigr)\Bigr)
&&\left(\because\ w^{S}_p=z^{S}_i=a_i\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\prod_{A,\,k=1}^{M}w^{S}_k
&&\left(\because\ \text{族}\ w^{S}\ \text{に}\ n:=M\ \text{で当てる。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A a_{T\cup\{i\}}
&&\left(\because\ S=T\cup\{i\}\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero",
    kind: "claim",
    title: { text: "番号を含む部分集合の消滅の逆順の積に、その番号の消滅作用素にあたる元を右から掛けると零になる" },
    labels: ["claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a_T`), " を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " の元とする。", math(String.raw`T\in\mathcal{P}_M`), "、", math(String.raw`i\in\{1,\dots,M\}`),
        " が ", math(String.raw`i\in T`), " を満たすとき、次が成り立つ。",
      ]),
      displayMath(String.raw`a_T\cdot_{\mathrm{Cl}(V,q)}a_i=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`p:=M+1-i`), " と置き、", math(String.raw`L:=\prod_{A,\,k=1}^{M-i}w^{T}_k`), "、",
        math(String.raw`Q:=Q_{i-1}`), "（", ref("claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"), "）と置く。",
        ref("claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index"), " の証明と同じく ", math(String.raw`Q=\prod_{A,\,r=1}^{i-1}w^{T}_{p+r}`),
        " であり、", math(String.raw`i\in T`), " なので ", math(String.raw`w^{T}_p=z^{T}_i=a_i`), " である（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"),
        "）。", math(String.raw`\varsigma`), " と ", math(String.raw`N_i(T)`), " は ", ref("claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"),
        " のものである。積 ", math(String.raw`0_A\cdot_A y`), " と ", math(String.raw`y\cdot_A 0_A`), "（", math(String.raw`y\in A`), "）が ", math(String.raw`0_A`),
        " であることは、", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_linear_map_sends_zero_to_zero"), " による。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_T\cdot_A a_i
&=\Bigl(L\cdot_A\bigl(a_i\cdot_A Q\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ n:=M\text{、}w^{T}_p=a_i\text{。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A Q\bigr)\cdot_A a_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\bigl(Q\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A Q\bigr)\Bigr)\Bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_initial_annihilation_factors_pass_annihilation_generator_with_sign}\right)\\
&=L\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A(a_i\cdot_A Q)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a_i\cdot_A(a_i\cdot_A Q)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl((a_i\cdot_A a_i)\cdot_A Q\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(0_A\cdot_A Q\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A 0_A\bigr)
&&\left(\because\ \text{右から}\ Q\ \text{を掛ける写像は線型}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A 0_A
&&\left(\because\ \text{左から}\ L\ \text{を掛ける写像は線型}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_global_identities_in_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数の中の大域的な等式" },
    labels: [],
  },
  {
    id: "isomorphism_claim_annihilation_generator_commutes_with_other_number_reversed_pair",
    kind: "claim",
    title: { text: "消滅作用素にあたる元は、番号の違う生成と消滅の積と交換する" },
    labels: ["claim_annihilation_generator_commutes_with_other_number_reversed_pair"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`i\neq j`), " であるすべての ", math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a_i\cdot_A\bigl(a^{\dagger}_j\cdot_A a_j\bigr)=\bigl(a^{\dagger}_j\cdot_A a_j\bigr)\cdot_A a_i`),
    ],
    proof: [
      paragraph([math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"), " のものである。準備として、", math(String.raw`i\neq j`), " なので ", math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A a^{\dagger}_j+_A a^{\dagger}_j\cdot_A a_i
&=\delta_{i,j}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ i\neq j\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A\bigl(a^{\dagger}_j\cdot_A a_j\bigr)
&=\bigl(a_i\cdot_A a^{\dagger}_j\bigr)\cdot_A a_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a_i)\bigr)\cdot_A a_j
&&\left(\because\ p:=a_i\text{、}q:=a^{\dagger}_j\text{。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a^{\dagger}_j\cdot_A a_i)\cdot_A a_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_j\cdot_A(a_i\cdot_A a_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a^{\dagger}_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ p:=a_i\text{、}q:=a_j\text{。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a^{\dagger}_j\cdot_A a_j\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factors_with_different_numbers_commute",
    kind: "claim",
    title: { text: "番号の違う消滅と生成の積どうしは交換する" },
    labels: ["claim_vacuum_factors_with_different_numbers_commute"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`i\neq j`), " であるすべての ", math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A x_j=x_j\cdot_A x_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A x_j
&=\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A x_j
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A x_j\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\bigl(x_j\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ i\neq j\text{。}\blkref{claim_creation_generator_commutes_with_other_number_pair}\right)\\
&=\bigl(a_i\cdot_A x_j\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(x_j\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ i\neq j\text{。}\blkref{claim_annihilation_generator_commutes_with_other_number_pair}\right)\\
&=x_j\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=x_j\cdot_A x_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator",
    kind: "claim",
    title: { text: "消滅と生成の積に同じ番号の消滅作用素にあたる元を右から掛けると、その消滅作用素にあたる元になる" },
    labels: ["claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A a_i=a_i`),
    ],
    proof: [
      paragraph(["準備。積 ", math(String.raw`0_A\cdot_A w`), " と ", math(String.raw`w\cdot_A 0_A`), "（", math(String.raw`w\in A`), "）が ", math(String.raw`0_A`), " であることは、右から ", math(String.raw`w`), " を掛ける写像と左から ", math(String.raw`w`), " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。"]),
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A a_i
&=\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A a_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=0_A+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(0_A\cdot_A a^{\dagger}_i\bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \text{準備（右から}\ a^{\dagger}_i\ \text{を掛ける写像）}\right)\\
&=\bigl((a_i\cdot_A a_i)\cdot_A a^{\dagger}_i\bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=\Bigl(a_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\Bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（左の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\bigl(\delta_{i,i}\ast_A 1_A\bigr)
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=a_i\cdot_A\bigl(1_{\mathbb{C}}\ast_A 1_A\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=a_i\cdot_A 1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_vacuum_factor_is_creation_generator",
    kind: "claim",
    title: { text: "消滅と生成の積に同じ番号の生成作用素にあたる元を左から掛けると、その生成作用素にあたる元になる" },
    labels: ["claim_creation_generator_times_vacuum_factor_is_creation_generator"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a^{\dagger}_i\cdot_A x_i=a^{\dagger}_i`),
    ],
    proof: [
      paragraph(["準備。積 ", math(String.raw`0_A\cdot_A w`), " と ", math(String.raw`w\cdot_A 0_A`), "（", math(String.raw`w\in A`), "）が ", math(String.raw`0_A`), " であることは、右から ", math(String.raw`w`), " を掛ける写像と左から ", math(String.raw`w`), " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A x_i
&=a^{\dagger}_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=0_A+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a_i\cdot_A 0_A\bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ \text{準備（左から}\ a_i\ \text{を掛ける写像）}\right)\\
&=\bigl(a_i\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_i)\bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A a^{\dagger}_i\Bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（右の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=\bigl(\delta_{i,i}\ast_A 1_A\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=\bigl(1_{\mathbb{C}}\ast_A 1_A\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_A\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_is_idempotent",
    kind: "claim",
    title: { text: "消滅と生成の積の自分自身との積は、もとの積である" },
    labels: ["claim_vacuum_factor_is_idempotent"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A x_i=x_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A x_i
&=x_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=\bigl(x_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=x_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_initial_reverse_ordered_product_of_selected_annihilation_generators",
    kind: "definition",
    title: { text: "部分集合の元のうち番号が m 以下のものの、消滅作用素にあたる元の番号の逆順の積" },
    labels: ["def_initial_reverse_ordered_product_of_selected_annihilation_generators"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とし、", math(String.raw`z^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " と ", math(String.raw`k\in\{1,\dots,m\}`), " について ", math(String.raw`m+1-k\in\{1,\dots,m\}`), " なので、", math(String.raw`k`), " に ", math(String.raw`z^{T}_{m+1-k}`), " を与える族が定まる。", math(String.raw`A`), " の元 ", math(String.raw`a_{T,\le m}`), " を、その族の ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`a_{T,\le m}:=\prod_{A,\,k=1}^{m}z^{T}_{m+1-k}`),
      paragraph([math(String.raw`a_{T,\le m}`), " は ", math(String.raw`z^{T}_m,\dots,z^{T}_1`), " をこの順に左から右へ掛けた積である。", math(String.raw`a_{T,\le 0}=1_A`), " である（", ref("def_ordered_product_in_algebra"), "）。", math(String.raw`m=M`), " のとき、族 ", math(String.raw`k\mapsto z^{T}_{M+1-k}`), " は ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " の族 ", math(String.raw`w^{T}_k`), " と同じ族なので、", math(String.raw`a_{T,\le M}=a_T`), " である。"]),
    ],
  },
  {
    id: "isomorphism_definition_initial_ordered_product_of_selected_creation_generators",
    kind: "definition",
    title: { text: "部分集合の元のうち番号が m 以下のものの、生成作用素にあたる元の番号順の積" },
    labels: ["def_initial_ordered_product_of_selected_creation_generators"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`U\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とし、", math(String.raw`y^{U}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ", ref("def_ordered_product_of_selected_creation_generators"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`a^{\dagger}_{U,\le m}`), " を、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`a^{\dagger}_{U,\le m}:=\prod_{A,\,t=1}^{m}y^{U}_t`),
      paragraph(["部分積の式は番号 ", math(String.raw`m`), " までの因子だけで定まるので、", math(String.raw`a^{\dagger}_{U,\le m}`), " は ", ref("def_ordered_product_of_selected_creation_generators"), " の積の部分積 ", math(String.raw`\Pi_m`), " と同じ元である。したがって ", math(String.raw`a^{\dagger}_{U,\le 0}=1_A`), "、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`a^{\dagger}_{U,\le m}=a^{\dagger}_{U,\le m-1}\cdot_A y^{U}_m`), "、", math(String.raw`a^{\dagger}_{U,\le M}=a^{\dagger}_U`), " である（", ref("def_ordered_product_in_algebra"), "）。"]),
    ],
  },
  {
    id: "isomorphism_definition_initial_part_of_vacuum_element",
    kind: "definition",
    title: { text: "真空への射影にあたる元の、番号が m 以下の因子の積" },
    labels: ["def_initial_part_of_vacuum_element"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`P_{\le m}`), " を、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`P_{\le m}:=\prod_{A,\,i=1}^{m}x_i`),
      paragraph([math(String.raw`P_{\le m}`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"), " の積の部分積 ", math(String.raw`\Pi_m`), " と同じ元である。したがって ", math(String.raw`P_{\le 0}=1_A`), "、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`P_{\le m}=P_{\le m-1}\cdot_A x_m`), "、", math(String.raw`P_{\le M}=P`), " である（", ref("def_ordered_product_in_algebra"), "）。"]),
    ],
  },
  {
    id: "isomorphism_definition_vacuum_sandwich_of_initial_parts",
    kind: "definition",
    title: { text: "番号が m 以下の部分の消滅と生成の積を、真空への射影にあたる元の番号が m 以下の因子の積で挟んだ元" },
    labels: ["def_vacuum_sandwich_of_initial_parts"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{0,1,\dots,M\}`), " とし、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), " のものとする。", math(String.raw`A`), " の元 ", math(String.raw`Q^{T,U}_m`), " を次で定める。"]),
      displayMath(String.raw`Q^{T,U}_m:=\Bigl(P_{\le m}\cdot_A\bigl(a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}\bigr)\Bigr)\cdot_A P_{\le m}`),
      paragraph([math(String.raw`m=M`), " のとき、", math(String.raw`a_{T,\le M}=a_T`), "、", math(String.raw`a^{\dagger}_{U,\le M}=a^{\dagger}_U`), "、", math(String.raw`P_{\le M}=P`), "（", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", ref("def_initial_part_of_vacuum_element"), "）なので、", math(String.raw`Q^{T,U}_M=\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P`), " である。"]),
    ],
  },
  {
    id: "isomorphism_claim_initial_reverse_ordered_annihilation_product_splits_off_last_number",
    kind: "claim",
    title: { text: "番号が m 以下の消滅の逆順の積は、番号 m の因子と、番号が m-1 以下の消滅の逆順の積との積である" },
    labels: ["claim_initial_reverse_ordered_annihilation_product_splits_off_last_number"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T\in\mathcal{P}_M`), " とし、", math(String.raw`z^{T}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a_{T,\le m}=z^{T}_m\cdot_A a_{T,\le m-1}`),
    ],
    proof: [
      paragraph([math(String.raw`s\in\{1,\dots,m\}`), " について ", math(String.raw`w_s:=z^{T}_{m+1-s}`), " と置く。", math(String.raw`w_1=z^{T}_m`), " であり、", math(String.raw`r\in\{1,\dots,m-1\}`), " について ", math(String.raw`w_{1+r}=z^{T}_{m-r}=z^{T}_{(m-1)+1-r}`), " なので、族 ", math(String.raw`r\mapsto w_{1+r}`), " は ", math(String.raw`a_{T,\le m-1}`), " を定める族と同じ族である。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}
&=\prod_{A,\,s=1}^{m}w_s
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=\left(\prod_{A,\,s=1}^{1}w_s\right)\cdot_A\left(\prod_{A,\,r=1}^{m-1}w_{1+r}\right)
&&\left(\because\ k:=1\text{、}l:=m-1\text{。}\blkref{claim_ordered_product_in_algebra_splits_into_first_and_last_factors}\right)\\
&=\bigl(1_A\cdot_A w_1\bigr)\cdot_A\left(\prod_{A,\,r=1}^{m-1}w_{1+r}\right)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=w_1\cdot_A\left(\prod_{A,\,r=1}^{m-1}w_{1+r}\right)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=z^{T}_m\cdot_A\left(\prod_{A,\,r=1}^{m-1}z^{T}_{(m-1)+1-r}\right)
&&\left(\because\ w_1=z^{T}_m\text{、}w_{1+r}=z^{T}_{(m-1)+1-r}\right)\\
&=z^{T}_m\cdot_A a_{T,\le m-1}
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_commutes_with_lower_initial_parts",
    kind: "claim",
    title: { text: "番号 m の消滅と生成の積は、番号が m-1 以下の部分の消滅と生成の積と交換する" },
    labels: ["claim_vacuum_factor_commutes_with_lower_initial_parts"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_m\cdot_A\bigl(a_{T,\le m-1}\cdot_A a^{\dagger}_{U,\le m-1}\bigr)=\bigl(a_{T,\le m-1}\cdot_A a^{\dagger}_{U,\le m-1}\bigr)\cdot_A x_m`),
    ],
    proof: [
      paragraph([math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`1_A`), " はどの元とも交換する（", math(String.raw`x_m\cdot_A 1_A=x_m=1_A\cdot_A x_m`), "。", ref("def_unital_ring"), " の乗法の単位元）。", math(String.raw`t\in\{1,\dots,m-1\}`), " とする。", math(String.raw`t\in T`), " なら ", math(String.raw`z^{T}_t=a_t`), " であり、", math(String.raw`t\neq m`), " なので ", math(String.raw`a_t\cdot_A x_m=x_m\cdot_A a_t`), " である（", ref("claim_annihilation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てる）。", math(String.raw`t\notin T`), " なら ", math(String.raw`z^{T}_t=1_A`), " である。どちらでも ", math(String.raw`x_m\cdot_A z^{T}_t=z^{T}_t\cdot_A x_m`), " である。同じく ", math(String.raw`y^{U}_t`), " は ", math(String.raw`a^{\dagger}_t`), " か ", math(String.raw`1_A`), " であり、", math(String.raw`x_m\cdot_A y^{U}_t=y^{U}_t\cdot_A x_m`), " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てる）。", math(String.raw`\alpha`), " の因子は ", math(String.raw`z^{T}_{m-k}`), "（", math(String.raw`k\in\{1,\dots,m-1\}`), "、", math(String.raw`m-k\in\{1,\dots,m-1\}`), "）、", math(String.raw`\kappa`), " の因子は ", math(String.raw`y^{U}_t`), "（", math(String.raw`t\in\{1,\dots,m-1\}`), "）なので、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x_m`), " と二つの族に当てて、", math(String.raw`x_m\cdot_A\alpha=\alpha\cdot_A x_m`), "、", math(String.raw`x_m\cdot_A\kappa=\kappa\cdot_A x_m`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
x_m\cdot_A(\alpha\cdot_A\kappa)
&=(x_m\cdot_A\alpha)\cdot_A\kappa
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\alpha\cdot_A x_m)\cdot_A\kappa
&&\left(\because\ x_m\cdot_A\alpha=\alpha\cdot_A x_m\right)\\
&=\alpha\cdot_A(x_m\cdot_A\kappa)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\alpha\cdot_A(\kappa\cdot_A x_m)
&&\left(\because\ x_m\cdot_A\kappa=\kappa\cdot_A x_m\right)\\
&=(\alpha\cdot_A\kappa)\cdot_A x_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset",
    kind: "claim",
    title: { text: "番号 m がちょうど一方の部分集合に入るとき、番号が m 以下の部分を真空の因子で挟んだ元は零である" },
    labels: ["claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), "」が成り立つとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=0_A`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の四つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("def_initial_part_of_vacuum_element"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`x\cdot_A G=G\cdot_A x`), " である（", ref("claim_vacuum_factor_commutes_with_lower_initial_parts"), "）。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph(["（ニ）積 ", math(String.raw`0_A\cdot_A w`), " と ", math(String.raw`w\cdot_A 0_A`), "（", math(String.raw`w\in A`), "）が ", math(String.raw`0_A`), " であることは、右から ", math(String.raw`w`), " を掛ける写像と左から ", math(String.raw`w`), " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。"]),
      paragraph([math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), " のとき、", math(String.raw`z=a_m`), "、", math(String.raw`y=1_A`), " である（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", ref("def_ordered_product_of_selected_creation_generators"), "）。（ハ）と ", ref("def_unital_ring"), " の乗法の単位元により ", math(String.raw`a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=a_m\cdot_A(G\cdot_A 1_A)=a_m\cdot_A G`), " である。また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_m\cdot_A x
&=a_m\cdot_A(a_m\cdot_A a^{\dagger}_m)
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=(a_m\cdot_A a_m)\cdot_A a^{\dagger}_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=0_A\cdot_A a^{\dagger}_m
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=0_A
&&\left(\because\ \text{（ニ）}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A(a_m\cdot_A G)\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=a_m\cdot_A G\right)\\
&=\bigl((P'\cdot_A x)\cdot_A(a_m\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\Bigl(P'\cdot_A\bigl(x\cdot_A(a_m\cdot_A G)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A a_m)\cdot_A G\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(a_m\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A G)\cdot_A(P'\cdot_A x)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A G)\cdot_A(x\cdot_A P')\bigr)
&&\left(\because\ \text{（イ）}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl(G\cdot_A(x\cdot_A P')\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl((G\cdot_A x)\cdot_A P'\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl((x\cdot_A G)\cdot_A P'\bigr)\Bigr)
&&\left(\because\ \text{（ロ）}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl(x\cdot_A(G\cdot_A P')\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A x)\cdot_A(G\cdot_A P')\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl(0_A\cdot_A(G\cdot_A P')\bigr)
&&\left(\because\ a_m\cdot_A x=0_A\right)\\
&=P'\cdot_A 0_A
&&\left(\because\ \text{（ニ）}\right)\\
&=0_A
&&\left(\because\ \text{（ニ）}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), " のとき、", math(String.raw`z=1_A`), "、", math(String.raw`y=a^{\dagger}_m`), " である。（ハ）と ", ref("def_unital_ring"), " の乗法の単位元により ", math(String.raw`a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=1_A\cdot_A(G\cdot_A a^{\dagger}_m)=G\cdot_A a^{\dagger}_m`), " である。また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
x\cdot_A a^{\dagger}_m
&=(a_m\cdot_A a^{\dagger}_m)\cdot_A a^{\dagger}_m
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=a_m\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_m)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A 0_A
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=0_A
&&\left(\because\ \text{（ニ）}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=G\cdot_A a^{\dagger}_m\right)\\
&=\bigl((P'\cdot_A x)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\Bigl(P'\cdot_A\bigl(x\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A G)\cdot_A a^{\dagger}_m\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((G\cdot_A x)\cdot_A a^{\dagger}_m\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\Bigl(P'\cdot_A\bigl(G\cdot_A(x\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(G\cdot_A 0_A)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ x\cdot_A a^{\dagger}_m=0_A\right)\\
&=\bigl(P'\cdot_A 0_A\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ニ）}\right)\\
&=0_A\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ニ）}\right)\\
&=0_A
&&\left(\because\ \text{（ニ）}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_when_last_number_is_in_neither_subset",
    kind: "claim",
    title: { text: "番号 m がどちらの部分集合にも入らないとき、番号が m 以下の部分を真空の因子で挟んだ元は、m-1 以下の部分の元に番号 m の因子を右から掛けたものである" },
    labels: ["claim_vacuum_sandwich_when_last_number_is_in_neither_subset"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), " のとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=Q^{T,U}_{m-1}\cdot_A x_m`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の三つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("def_initial_part_of_vacuum_element"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`x\cdot_A G=G\cdot_A x`), " である（", ref("claim_vacuum_factor_commutes_with_lower_initial_parts"), "）。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\notin T`), "、", math(String.raw`m\notin U`), " なので ", math(String.raw`z=1_A`), "、", math(String.raw`y=1_A`), " である（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", ref("def_ordered_product_of_selected_creation_generators"), "）。（ハ）と ", ref("def_unital_ring"), " の乗法の単位元（二回）により ", math(String.raw`a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=1_A\cdot_A(G\cdot_A 1_A)=G`), " である。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A G\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=G\right)\\
&=\bigl((P'\cdot_A x)\cdot_A G\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\bigl(P'\cdot_A(x\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(G\cdot_A x)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A x\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A x\bigr)\cdot_A(x\cdot_A P')
&&\left(\because\ \text{（イ）}\right)\\
&=(P'\cdot_A G)\cdot_A\bigl(x\cdot_A(x\cdot_A P')\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(P'\cdot_A G)\cdot_A\bigl((x\cdot_A x)\cdot_A P'\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(P'\cdot_A G)\cdot_A(x\cdot_A P')
&&\left(\because\ \blkref{claim_vacuum_factor_is_idempotent}\right)\\
&=(P'\cdot_A G)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A P'\bigr)\cdot_A x
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=Q^{T,U}_{m-1}\cdot_A x_m
&&\left(\because\ G=\alpha\cdot_A\kappa\text{、}x=x_m\text{。}\blkref{def_vacuum_sandwich_of_initial_parts}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_when_last_number_is_in_both_subsets",
    kind: "claim",
    title: { text: "番号 m が両方の部分集合に入るとき、番号が m 以下の部分を真空の因子で挟んだ元は、m-1 以下の部分の元を番号 m の消滅と生成で挟んだものである" },
    labels: ["claim_vacuum_sandwich_when_last_number_is_in_both_subsets"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), " のとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の三つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("def_initial_part_of_vacuum_element"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`a_m\cdot_A x_j=x_j\cdot_A a_m`), "、", math(String.raw`a^{\dagger}_m\cdot_A x_j=x_j\cdot_A a^{\dagger}_m`), " であるから（", ref("claim_annihilation_generator_commutes_with_other_number_pair"), "、", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`a_m\cdot_A P'=P'\cdot_A a_m`), "、", math(String.raw`a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m`), " である。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\in T`), "、", math(String.raw`m\in U`), " なので ", math(String.raw`z=a_m`), "、", math(String.raw`y=a^{\dagger}_m`), " である（", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", ref("def_ordered_product_of_selected_creation_generators"), "）。（ハ）により ", math(String.raw`a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=a_m\cdot_A(G\cdot_A a^{\dagger}_m)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\Bigl(P_{\le m}\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、（ハ）}\right)\\
&=\Bigl((P'\cdot_A x)\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\biggl(P'\cdot_A\Bigl(x\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\biggr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A a_m)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=\bigl((P'\cdot_A a_m)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((a_m\cdot_A P')\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\Bigl(a_m\cdot_A\bigl(P'\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\bigl(P'\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\bigl((P'\cdot_A G)\cdot_A a^{\dagger}_m\bigr)\cdot_A(P'\cdot_A x)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(a^{\dagger}_m\cdot_A(P'\cdot_A x)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl((a^{\dagger}_m\cdot_A P')\cdot_A x\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl((P'\cdot_A a^{\dagger}_m)\cdot_A x\bigr)\Bigr)
&&\left(\because\ \text{（ロ）}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(P'\cdot_A(a^{\dagger}_m\cdot_A x)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(P'\cdot_A a^{\dagger}_m\bigr)\Bigr)
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right)\\
&=a_m\cdot_A\Bigl(\bigl((P'\cdot_A G)\cdot_A P'\bigr)\cdot_A a^{\dagger}_m\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ G=\alpha\cdot_A\kappa\text{。}\blkref{def_vacuum_sandwich_of_initial_parts}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part",
    kind: "claim",
    title: { text: "番号が m 以下の元が同じ二つの部分集合では、番号が m 以下の部分を真空の因子で挟んだ元は、真空の因子の積である" },
    labels: ["claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、すべての ", math(String.raw`t\in\{1,\dots,m\}`), " について「", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値である」ならば、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=P_{\le m}`),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、", math(String.raw`a_{T,\le 0}=a^{\dagger}_{U,\le 0}=P_{\le 0}=1_A`), " である（", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", ref("def_initial_part_of_vacuum_element"), "）。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_0
&=\bigl(1_A\cdot_A(1_A\cdot_A 1_A)\bigr)\cdot_A 1_A
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le 0}=a^{\dagger}_{U,\le 0}=P_{\le 0}=1_A\right)\\
&=(1_A\cdot_A 1_A)\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=P_{\le 0}
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。すべての ", math(String.raw`t\in\{1,\dots,m\}`), " について「", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値である」とする。", math(String.raw`\{1,\dots,m-1\}\subseteq\{1,\dots,m\}`), " なので ", math(String.raw`m-1`), " でも同じ条件が成り立ち、帰納法の仮定により ", math(String.raw`Q^{T,U}_{m-1}=P_{\le m-1}`), " である。", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`x:=x_m`), " と置く。", math(String.raw`P_{\le m}=P'\cdot_A x`), " である（", ref("def_initial_part_of_vacuum_element"), "）。", math(String.raw`t:=m`), " で条件を読むと、", math(String.raw`m\in T`), " と ", math(String.raw`m\in U`), " は同値なので、「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), "」のどちらかである。前者のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=Q^{T,U}_{m-1}\cdot_A x
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_neither_subset}\right)\\
&=P'\cdot_A x
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=P_{\le m}
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right).
\end{aligned}`),
      paragraph(["後者のとき、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`a^{\dagger}_m\cdot_A x_j=x_j\cdot_A a^{\dagger}_m`), "（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）と ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), "（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）が成り立つので、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m`), " と ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_both_subsets}\right)\\
&=a_m\cdot_A\bigl(P'\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=a_m\cdot_A\bigl(a^{\dagger}_m\cdot_A P'\bigr)
&&\left(\because\ a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m\right)\\
&=\bigl(a_m\cdot_A a^{\dagger}_m\bigr)\cdot_A P'
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=x\cdot_A P'
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=P'\cdot_A x
&&\left(\because\ x\cdot_A P'=P'\cdot_A x\right)\\
&=P_{\le m}
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero",
    kind: "claim",
    title: { text: "番号が m 以下の元が異なる二つの部分集合では、番号が m 以下の部分を真空の因子で挟んだ元は零である" },
    labels: ["claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、「", math(String.raw`t\in T`), " かつ ", math(String.raw`t\notin U`), "」か「", math(String.raw`t\notin T`), " かつ ", math(String.raw`t\in U`), "」を満たす ", math(String.raw`t\in\{1,\dots,m\}`), " が存在するならば、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=0_A`),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき ", math(String.raw`\{1,\dots,0\}`), " は空集合なので、条件を満たす ", math(String.raw`t`), " は存在せず、主張は条件を満たす場合が無いので成り立つ。", math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。条件を満たす ", math(String.raw`t\in\{1,\dots,m\}`), " をとる。積 ", math(String.raw`0_A\cdot_A w`), " と ", math(String.raw`w\cdot_A 0_A`), "（", math(String.raw`w\in A`), "）が ", math(String.raw`0_A`), " であることは、右から ", math(String.raw`w`), " を掛ける写像と左から ", math(String.raw`w`), " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。"]),
      paragraph([math(String.raw`t=m`), " のとき、「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), "」が成り立つので、", math(String.raw`Q^{T,U}_m=0_A`), " である（", ref("claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"), "）。"]),
      paragraph([math(String.raw`t\neq m`), " のとき、", math(String.raw`t\in\{1,\dots,m-1\}`), " なので ", math(String.raw`m-1`), " で条件が成り立ち、帰納法の仮定により ", math(String.raw`Q^{T,U}_{m-1}=0_A`), " である。番号 ", math(String.raw`m`), " については、「", math(String.raw`m`), " がちょうど一方に入る」「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), "」「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), "」のどれか一つが成り立つ。一つ目のときは ", ref("claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"), " により ", math(String.raw`Q^{T,U}_m=0_A`), " である。二つ目のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=Q^{T,U}_{m-1}\cdot_A x_m
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_neither_subset}\right)\\
&=0_A\cdot_A x_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_A
&&\left(\because\ \text{右から}\ x_m\ \text{を掛ける写像が零を零へ移す}\right).
\end{aligned}`),
      paragraph(["三つ目のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_both_subsets}\right)\\
&=a_m\cdot_A\bigl(0_A\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=a_m\cdot_A 0_A
&&\left(\because\ \text{右から}\ a^{\dagger}_m\ \text{を掛ける写像が零を零へ移す}\right)\\
&=0_A
&&\left(\because\ \text{左から}\ a_m\ \text{を掛ける写像が零を零へ移す}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_element_sandwich_of_annihilation_and_creation_products",
    kind: "claim",
    title: { text: "消滅の逆順の積と生成の積の積を真空への射影にあたる元で挟むと、二つの部分集合が等しいときだけ真空への射影にあたる元が残る" },
    labels: ["claim_vacuum_element_sandwich_of_annihilation_and_creation_products"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_U`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のもの、", math(String.raw`\delta_{T,U}`), " を集合 ", math(String.raw`\mathcal{P}_M`), " の上のクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。すべての ", math(String.raw`T,U\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P=\delta_{T,U}\ast_A P`),
    ],
    proof: [
      paragraph([math(String.raw`Q^{T,U}_M`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとすると、", math(String.raw`Q^{T,U}_M=\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P`), " である（", ref("def_vacuum_sandwich_of_initial_parts"), "）。", math(String.raw`T=U`), " のとき、すべての ", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " は同値である。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P
&=Q^{T,U}_M
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\right)\\
&=P_{\le M}
&&\left(\because\ m:=M\text{。}\blkref{claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part}\right)\\
&=P
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right)\\
&=1_{\mathbb{C}}\ast_A P
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{T,U}\ast_A P
&&\left(\because\ T=U\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([math(String.raw`T\neq U`), " のとき、集合の等しさ（", ref("def_power_set_of_first_m_positive_integers"), "）により、", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値でない ", math(String.raw`t\in\{1,\dots,M\}`), " が存在する。その ", math(String.raw`t`), " では「", math(String.raw`t\in T`), " かつ ", math(String.raw`t\notin U`), "」か「", math(String.raw`t\notin T`), " かつ ", math(String.raw`t\in U`), "」が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P
&=Q^{T,U}_M
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\right)\\
&=0_A
&&\left(\because\ m:=M\text{。}\blkref{claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero}\right)\\
&=0_{\mathbb{C}}\ast_A P
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{T,U}\ast_A P
&&\left(\because\ T\neq U\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_selected_number_factor_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "部分集合に入るかどうかで選ぶ、番号ごとの生成と消滅の積" },
    labels: ["def_selected_number_factor_of_split_clifford_algebra"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`S\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`u^{S}_i`), " を次で定める（", math(String.raw`i\in S`), " の真偽は ", ref("def_power_set_of_first_m_positive_integers"), " により一つに決まる）。"]),
      displayMath(String.raw`u^{S}_i:=\begin{cases}a^{\dagger}_i\cdot_A a_i & (i\in S),\\ a_i\cdot_A a^{\dagger}_i & (i\notin S).\end{cases}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_vacuum_annihilation_factor_of_one_number",
    kind: "claim",
    title: { text: "一つの番号について、生成の因子と消滅と生成の積と消滅の因子をこの順に掛けると、部分集合で選んだ積になる" },
    labels: ["claim_creation_vacuum_annihilation_factor_of_one_number"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`S\in\mathcal{P}_M`), " とし、", math(String.raw`y^{S}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{S}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i=u^{S}_i`),
    ],
    proof: [
      paragraph([math(String.raw`i\in S`), " のとき、", math(String.raw`y^{S}_i=a^{\dagger}_i`), "、", math(String.raw`z^{S}_i=a_i`), " である（", ref("def_ordered_product_of_selected_creation_generators"), "、", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i
&=\bigl(a^{\dagger}_i\cdot_A x_i\bigr)\cdot_A a_i
&&\left(\because\ y^{S}_i=a^{\dagger}_i\text{、}z^{S}_i=a_i\right)\\
&=a^{\dagger}_i\cdot_A a_i
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right)\\
&=u^{S}_i
&&\left(\because\ i\in S\text{。}\blkref{def_selected_number_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`i\notin S`), " のとき、", math(String.raw`y^{S}_i=1_A`), "、", math(String.raw`z^{S}_i=1_A`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i
&=\bigl(1_A\cdot_A x_i\bigr)\cdot_A 1_A
&&\left(\because\ y^{S}_i=z^{S}_i=1_A\right)\\
&=x_i\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=x_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=u^{S}_i
&&\left(\because\ i\notin S\text{。}\blkref{def_selected_number_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors",
    kind: "claim",
    title: { text: "番号が m 以下の部分の生成の積と真空の因子の積と消滅の逆順の積の積は、部分集合で選んだ番号ごとの積の番号順の積である" },
    labels: ["claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`S\in\mathcal{P}_M`), " とし、", math(String.raw`a^{\dagger}_{S,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`a_{S,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`m\in\{0,1,\dots,M\}`), " について、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ。"]),
      displayMath(String.raw`\bigl(a^{\dagger}_{S,\le m}\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}=\prod_{A,\,i=1}^{m}u^{S}_i`),
    ],
    proof: [
      paragraph([math(String.raw`\Pi_m:=\prod_{A,\,i=1}^{m}u^{S}_i`), " と置く。部分積の式は番号 ", math(String.raw`m`), " までの因子だけで定まるので、", math(String.raw`\Pi_0=1_A`), "、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A u^{S}_m`), " である（", ref("def_ordered_product_in_algebra"), "）。", math(String.raw`y^{S}_t`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{S}_t`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、", math(String.raw`a^{\dagger}_{S,\le 0}=P_{\le 0}=a_{S,\le 0}=1_A`), " である（", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", ref("def_initial_part_of_vacuum_element"), "、", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a^{\dagger}_{S,\le 0}\cdot_A P_{\le 0}\bigr)\cdot_A a_{S,\le 0}
&=(1_A\cdot_A 1_A)\cdot_A 1_A
&&\left(\because\ a^{\dagger}_{S,\le 0}=P_{\le 0}=a_{S,\le 0}=1_A\right)\\
&=1_A\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\Pi_0
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`\kappa:=a^{\dagger}_{S,\le m-1}`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{S,\le m-1}`), "、", math(String.raw`x:=x_m`), "、", math(String.raw`y:=y^{S}_m`), "、", math(String.raw`z:=z^{S}_m`), "、", math(String.raw`u:=u^{S}_m`), " と置く（", math(String.raw`x_m`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"), " のもの）。準備として次の二つが成り立つ。", math(String.raw`1_A`), " はどの元とも交換する（", ref("def_unital_ring"), " の乗法の単位元）。"]),
      paragraph(["（イ）", math(String.raw`y\cdot_A P'=P'\cdot_A y`), "。", math(String.raw`j\in\{1,\dots,m-1\}`), " とする。", math(String.raw`m\in S`), " なら ", math(String.raw`y=a^{\dagger}_m`), " であり、", math(String.raw`m\neq j`), " なので ", math(String.raw`y\cdot_A x_j=x_j\cdot_A y`), " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）。", math(String.raw`m\notin S`), " なら ", math(String.raw`y=1_A`), " である。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=y`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて（イ）を得る。"]),
      paragraph(["（ロ）", math(String.raw`u\cdot_A\alpha=\alpha\cdot_A u`), "。", math(String.raw`\alpha`), " の因子は ", math(String.raw`z^{S}_{m-k}`), "（", math(String.raw`k\in\{1,\dots,m-1\}`), "）であり、", math(String.raw`t:=m-k\in\{1,\dots,m-1\}`), " なので ", math(String.raw`t\neq m`), " である。", math(String.raw`t\in S`), " なら ", math(String.raw`z^{S}_t=a_t`), " であり、", math(String.raw`u=a^{\dagger}_m\cdot_A a_m`), " のとき ", ref("claim_annihilation_generator_commutes_with_other_number_reversed_pair"), "、", math(String.raw`u=a_m\cdot_A a^{\dagger}_m`), " のとき ", ref("claim_annihilation_generator_commutes_with_other_number_pair"), " を ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てて、", math(String.raw`a_t\cdot_A u=u\cdot_A a_t`), " である。", math(String.raw`t\notin S`), " なら ", math(String.raw`z^{S}_t=1_A`), " である。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u`), " と ", math(String.raw`\alpha`), " を定める族に当てて（ロ）を得る。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a^{\dagger}_{S,\le m}\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}
&=\bigl((\kappa\cdot_A y)\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=\bigl((\kappa\cdot_A y)\cdot_A(P'\cdot_A x)\bigr)\cdot_A a_{S,\le m}
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right)\\
&=\bigl((\kappa\cdot_A y)\cdot_A(P'\cdot_A x)\bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\Bigl(\kappa\cdot_A\bigl(y\cdot_A(P'\cdot_A x)\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\kappa\cdot_A\bigl((y\cdot_A P')\cdot_A x\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\kappa\cdot_A\bigl((P'\cdot_A y)\cdot_A x\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ \text{（イ）}\right)\\
&=\Bigl(\kappa\cdot_A\bigl(P'\cdot_A(y\cdot_A x)\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((\kappa\cdot_A P')\cdot_A(y\cdot_A x)\bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A\bigl((y\cdot_A x)\cdot_A(z\cdot_A\alpha)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A\Bigl(\bigl((y\cdot_A x)\cdot_A z\bigr)\cdot_A\alpha\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A(u\cdot_A\alpha)
&&\left(\because\ i:=m\text{。}\blkref{claim_creation_vacuum_annihilation_factor_of_one_number}\right)\\
&=(\kappa\cdot_A P')\cdot_A(\alpha\cdot_A u)
&&\left(\because\ \text{（ロ）}\right)\\
&=\bigl((\kappa\cdot_A P')\cdot_A\alpha\bigr)\cdot_A u
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Pi_{m-1}\cdot_A u
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\Pi_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_sum_over_subsets_of_selected_products_is_product_of_sums",
    kind: "claim",
    title: { text: "部分集合ごとに因子を選んだ番号順の積を、部分集合の 2 進の番号付けの順に足すと、因子の和の番号順の積になる" },
    labels: ["claim_sum_over_subsets_of_selected_products_is_product_of_sums"],
    statement: [
      paragraph([math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`M\in\mathbb{Z}_{\ge 0}`), " とし、", math(String.raw`\{1,\dots,M\}`), " の各元 ", math(String.raw`i`), " に ", math(String.raw`B`), " の元 ", math(String.raw`g_i`), " と ", math(String.raw`h_i`), " が一つずつ与えられているとする。", math(String.raw`S\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）と ", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`B`), " の元 ", math(String.raw`v^{S}_i`), " を、", math(String.raw`i\in S`), " なら ", math(String.raw`v^{S}_i:=g_i`), "、", math(String.raw`i\notin S`), " なら ", math(String.raw`v^{S}_i:=h_i`), " と定める。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`2^m`), " と ", math(String.raw`e_m:\{1,\dots,2^m\}\to\mathcal{P}_m`), " を ", ref("def_binary_numbering_of_power_set"), " のものとする。", math(String.raw`\{1,\dots,m\}\subseteq\{1,\dots,M\}`), " なので ", math(String.raw`\mathcal{P}_m\subseteq\mathcal{P}_M`), " であり、", math(String.raw`v^{e_m(k)}_i`), " は定まる。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`U_{\mathrm{vec}}(B)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（", ref("def_linear_combination"), "）と、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ。"]),
      displayMath(String.raw`\sum_{k=1}^{2^m}1_{\mathbb{C}}\ast_B\prod_{B,\,i=1}^{m}v^{e_m(k)}_i=\prod_{B,\,i=1}^{m}\bigl(h_i+_B g_i\bigr)`),
    ],
    proof: [
      paragraph([math(String.raw`S\in\mathcal{P}_M`), " と ", math(String.raw`m\in\{0,1,\dots,M\}`), " について ", math(String.raw`F_m(S):=\prod_{B,\,i=1}^{m}v^{S}_i`), "、", math(String.raw`\Pi_m:=\prod_{B,\,i=1}^{m}(h_i+_B g_i)`), " と置く。部分積の式は番号 ", math(String.raw`m`), " までの因子だけで定まるので、", math(String.raw`F_0(S)=1_B`), "、", math(String.raw`\Pi_0=1_B`), "、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`F_m(S)=F_{m-1}(S)\cdot_B v^{S}_m`), "、", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_B(h_m+_B g_m)`), " である（", ref("def_ordered_product_in_algebra"), "）。項が等しい二つの族の線型結合は等しい（", ref("def_linear_combination"), " の帰納的な定義は項だけで決まる）。", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、", math(String.raw`2^0=1`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{1}1_{\mathbb{C}}\ast_B F_0\bigl(e_0(k)\bigr)
&=0_B+_B\Bigl(1_{\mathbb{C}}\ast_B F_0\bigl(e_0(1)\bigr)\Bigr)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=0_B+_B\bigl(1_{\mathbb{C}}\ast_B 1_B\bigr)
&&\left(\because\ F_0\bigl(e_0(1)\bigr)=1_B\right)\\
&=0_B+_B 1_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_B+_B 0_B
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=1_B
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\Pi_0
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`n:=2^{m-1}`), " と置くと、", math(String.raw`2^m=2\cdot n=n+n`), " である（", ref("def_binary_numbering_of_power_set"), "）。準備として次の三つが成り立つ。"]),
      paragraph(["（イ）", math(String.raw`k\in\{1,\dots,n\}`), " について ", math(String.raw`F_m(e_m(k))=F_{m-1}(e_{m-1}(k))\cdot_B h_m`), "。", math(String.raw`k\le 2^{m-1}`), " なので ", math(String.raw`e_m(k)=e_{m-1}(k)`), " であり（", ref("def_binary_numbering_of_power_set"), "）、", math(String.raw`e_{m-1}(k)\subseteq\{1,\dots,m-1\}`), " なので ", math(String.raw`m\notin e_m(k)`), "、", math(String.raw`v^{e_m(k)}_m=h_m`), " である。したがって ", math(String.raw`F_m(e_m(k))=F_{m-1}(e_m(k))\cdot_B v^{e_m(k)}_m=F_{m-1}(e_{m-1}(k))\cdot_B h_m`), " である。"]),
      paragraph(["（ロ）", math(String.raw`j\in\{1,\dots,n\}`), " について ", math(String.raw`F_m(e_m(n+j))=F_{m-1}(e_{m-1}(j))\cdot_B g_m`), "。", math(String.raw`n<n+j\le 2^m`), " なので ", math(String.raw`e_m(n+j)=e_{m-1}(j)\cup\{m\}`), " である（", ref("def_binary_numbering_of_power_set"), "）。", math(String.raw`i\in\{1,\dots,m-1\}`), " なら ", math(String.raw`i\neq m`), " なので、", math(String.raw`i\in e_m(n+j)`), " と ", math(String.raw`i\in e_{m-1}(j)`), " は同値であり、", math(String.raw`v^{e_m(n+j)}_i=v^{e_{m-1}(j)}_i`), " である。部分積の式は番号 ", math(String.raw`m-1`), " までの因子だけで定まるので ", math(String.raw`F_{m-1}(e_m(n+j))=F_{m-1}(e_{m-1}(j))`), " である。また ", math(String.raw`m\in e_m(n+j)`), " なので ", math(String.raw`v^{e_m(n+j)}_m=g_m`), " である。したがって ", math(String.raw`F_m(e_m(n+j))=F_{m-1}(e_m(n+j))\cdot_B g_m=F_{m-1}(e_{m-1}(j))\cdot_B g_m`), " である。"]),
      paragraph(["（ハ）", math(String.raw`w\in B`), " について、右から ", math(String.raw`w`), " を掛ける写像は ", math(String.raw`U_{\mathrm{vec}}(B)`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像である（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "）。したがって ", ref("claim_linear_map_maps_linear_combination_to_linear_combination_of_values"), " により、", math(String.raw`\{1,\dots,n\}`), " の上の ", math(String.raw`B`), " の元の族 ", math(String.raw`X_k`), " について ", math(String.raw`\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B(X_k\cdot_B w)=\bigl(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B X_k\bigr)\cdot_B w`), " である。"]),
      paragraph(["帰納法の仮定は ", math(String.raw`\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}(e_{m-1}(k))=\Pi_{m-1}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{2^m}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(k)\bigr)
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(k)\bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(n+j)\bigr)\right)
&&\left(\because\ 2^m=n+n\text{、}n':=n\text{。}\blkref{claim_splitting_linear_combination_into_first_and_last_terms}\right)\\
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(k)\bigr)\cdot_B h_m\Bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(n+j)\bigr)\right)
&&\left(\because\ \text{（イ）}\right)\\
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(k)\bigr)\cdot_B h_m\Bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(j)\bigr)\cdot_B g_m\Bigr)\right)
&&\left(\because\ \text{（ロ）}\right)\\
&=\left(\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}\bigl(e_{m-1}(k)\bigr)\right)\cdot_B h_m\right)+_B\left(\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}\bigl(e_{m-1}(j)\bigr)\right)\cdot_B g_m\right)
&&\left(\because\ \text{（ハ）を}\ w:=h_m\ \text{と}\ w:=g_m\ \text{の二か所に適用}\right)\\
&=\bigl(\Pi_{m-1}\cdot_B h_m\bigr)+_B\bigl(\Pi_{m-1}\cdot_B g_m\bigr)
&&\left(\because\ \text{帰納法の仮定を二か所に適用}\right)\\
&=\Pi_{m-1}\cdot_B\bigl(h_m+_B g_m\bigr)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の分配法則（左の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=\Pi_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_decomposition_of_unity_in_split_clifford_algebra",
    kind: "claim",
    title: { text: "生成の積と真空への射影にあたる元と消滅の逆順の積の積を、部分集合全体の上で足すと 1 になる" },
    labels: ["claim_decomposition_of_unity_in_split_clifford_algebra"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`a^{\dagger}_S`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_S`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`\mathcal{P}_M`), " は有限集合である（", ref("claim_binary_numbering_is_numbering_of_power_set"), "）。", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）について次が成り立つ。"]),
      displayMath(String.raw`\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)=1_A`),
    ],
    proof: [
      paragraph([math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。準備として次の四つが成り立つ。"]),
      paragraph(["（イ）", math(String.raw`S\in\mathcal{P}_M`), " について ", math(String.raw`(a^{\dagger}_S\cdot_A P)\cdot_A a_S=\prod_{A,\,i=1}^{M}u^{S}_i`), "。", math(String.raw`a^{\dagger}_{S,\le M}=a^{\dagger}_S`), "、", math(String.raw`P_{\le M}=P`), "、", math(String.raw`a_{S,\le M}=a_S`), " であり（", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", ref("def_initial_part_of_vacuum_element"), "、", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "）、", ref("claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors"), " を ", math(String.raw`m:=M`), " で当てる。"]),
      paragraph(["（ロ）", ref("claim_sum_over_subsets_of_selected_products_is_product_of_sums"), " を ", math(String.raw`B:=A`), "、", math(String.raw`g_i:=a^{\dagger}_i\cdot_A a_i`), "、", math(String.raw`h_i:=a_i\cdot_A a^{\dagger}_i`), "、", math(String.raw`m:=M`), " で当てる。このとき ", ref("def_selected_number_factor_of_split_clifford_algebra"), " により ", math(String.raw`v^{S}_i=u^{S}_i`), " である。"]),
      paragraph(["（ハ）", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)
&=\delta_{i,i}\ast_A 1_A
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=1_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["（ニ）すべての因子が ", math(String.raw`1_A`), " の番号順の積は ", math(String.raw`1_A`), " である。部分積 ", math(String.raw`\Pi_m`), " について、", math(String.raw`\Pi_0=1_A`), " であり、", math(String.raw`\Pi_{m-1}=1_A`), " なら ", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A 1_A=\Pi_{m-1}=1_A`), " である（", ref("def_ordered_product_in_algebra"), "、", ref("def_unital_ring"), " の乗法の単位元）ので、", math(String.raw`m`), " についての帰納法により ", math(String.raw`\prod_{A,\,i=1}^{M}1_A=1_A`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\prod_{A,\,i=1}^{M}u^{S}_i
&&\left(\because\ \text{（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{k=1}^{2^M}1_{\mathbb{C}}\ast_A\prod_{A,\,i=1}^{M}u^{e_M(k)}_i
&&\left(\because\ \text{番号付け}\ (2^M,e_M)\text{。}\blkref{claim_binary_numbering_is_numbering_of_power_set}\text{、}\blkref{def_sum_over_finite_set}\right)\\
&=\prod_{A,\,i=1}^{M}\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \text{（ロ）。}\blkref{claim_sum_over_subsets_of_selected_products_is_product_of_sums}\right)\\
&=\prod_{A,\,i=1}^{M}1_A
&&\left(\because\ \text{（ハ）。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right)\\
&=1_A
&&\left(\because\ \text{（ニ）}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_homomorphism_from_matrix_algebra_to_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "行列環からクリフォード代数への準同型" },
    labels: [],
  },
  {
    id: "isomorphism_definition_matrix_unit_element_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "行列単位にあたる元" },
    labels: ["def_matrix_unit_element_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_S`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、",
        math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。",
        math(String.raw`S,T\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）について、", math(String.raw`A`), " の元 ", math(String.raw`e_{S,T}`),
        " を次で定める。",
      ]),
      displayMath(String.raw`e_{S,T}:=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T`),
      paragraph([
        math(String.raw`e_{S,T}`), " を行列単位にあたる元と呼ぶ。", math(String.raw`e_{S,T}`), " は ", math(String.raw`A`), " の元であり、", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元である行列単位 ", math(String.raw`E_{S,T}`), "（", ref("def_matrix_unit"), "）とは別の記号である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_product_of_matrix_unit_elements_of_split_clifford_algebra",
    kind: "claim",
    title: { text: "行列単位にあたる元の積の規則" },
    labels: ["claim_product_of_matrix_unit_elements_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものとし、",
        math(String.raw`\delta_{T,U}`), " を集合 ", math(String.raw`\mathcal{P}_M`), " の上のクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。すべての ",
        math(String.raw`S,T,U,R\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`e_{S,T}\cdot_A e_{U,R}=\delta_{T,U}\ast_A e_{S,R}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
e_{S,T}\cdot_A e_{U,R}
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T\Bigr)\cdot_A\Bigl(\bigl(a^{\dagger}_U\cdot_A P\bigr)\cdot_A a_R\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(a_T\cdot_A\Bigl(\bigl(a^{\dagger}_U\cdot_A P\bigr)\cdot_A a_R\Bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\Bigl(a_T\cdot_A\bigl(a^{\dagger}_U\cdot_A P\bigr)\Bigr)\cdot_A a_R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\cdot_A a_R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\Bigl(P\cdot_A\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\Bigl(\Bigl(P\cdot_A\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\Bigr)\cdot_A P\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\bigl(\delta_{T,U}\ast_A P\bigr)\Bigr)\cdot_A a_R
&&\left(\because\ \blkref{claim_vacuum_element_sandwich_of_annihilation_and_creation_products}\right)\\
&=\Bigl(\delta_{T,U}\ast_A\bigl(a^{\dagger}_S\cdot_A P\bigr)\Bigr)\cdot_A a_R
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\delta_{T,U}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_R\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\delta_{T,U}\ast_A e_{S,R}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_matrix_algebra_to_clifford_algebra",
    kind: "definition",
    title: { text: "行列環からクリフォード代数への写像" },
    labels: ["def_homomorphism_from_matrix_algebra_to_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"),
        " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "（", ref("def_matrices_indexed_by_finite_set"), "。", math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ", ref("claim_binary_numbering_is_numbering_of_power_set"), "）と書く。写像 ", math(String.raw`\Psi:B\to A`), " を、", math(String.raw`F\in B`),
        " について、", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"), "）で次のように定める。",
      ]),
      displayMath(String.raw`\Psi(F):=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\right)`),
      paragraph([
        "内側の和は、", math(String.raw`S`), " を固定して ", math(String.raw`T\in\mathcal{P}_M`), " に係数 ", math(String.raw`F_{S,T}\in\mathbb{C}`), " と元 ",
        math(String.raw`e_{S,T}\in A`), " を与えた族の和であり、外側の和は、", math(String.raw`S\in\mathcal{P}_M`), " にその内側の和と係数 ", math(String.raw`1_{\mathbb{C}}`),
        " を与えた族の和である。どちらの和も ", math(String.raw`\mathcal{P}_M`), " の番号付けの取り方によらず ", math(String.raw`A`), " の元として一つに決まる（",
        ref("def_sum_over_finite_set"), "）ので、", math(String.raw`\Psi(F)`), " は ", math(String.raw`A`), " の元として一つに決まる。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は線型写像である" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとする。",
        math(String.raw`\Psi`), " は ℂ-線型空間 ", math(String.raw`(B,+_B,\ast_B,0_B)`), "（", ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"), "。",
        math(String.raw`+_B,\ \ast_B,\ 0_B`), " は ", ref("def_matrices_indexed_by_finite_set"), " の ", math(String.raw`+_{\mathrm{Mat}_{\mathcal{P}_M}},\ \ast_{\mathrm{Mat}_{\mathcal{P}_M}},\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "）から ", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F,G\in B`), "、", math(String.raw`\rho\in\mathbb{C}`), " を任意にとる。和はすべて ", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`), " の上の和である。準備として次の三つが成り立つ。",
      ]),
      paragraph([
        "（イ）", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_sum_of_sums_over_finite_set_with_same_family"), " を ", math(String.raw`X:=\mathcal{P}_M`), "、",
        math(String.raw`v_T:=e_{S,T}`), "、", math(String.raw`\lambda_T:=F_{S,T}`), "、", math(String.raw`\mu_T:=G_{S,T}`), " に当て、右辺から左辺へ読んで、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}(F_{S,T}+_{\mathbb{C}}G_{S,T})\ast_A e_{S,T}=\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)+_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A e_{S,T}\Bigr)`),
        "。",
      ]),
      paragraph([
        "（ロ）", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_scalar_multiple_of_sum_over_finite_set"), " を ", math(String.raw`X:=\mathcal{P}_M`), "、",
        math(String.raw`v_T:=e_{S,T}`), "、", math(String.raw`\lambda_T:=F_{S,T}`), " に当て、右辺から左辺へ読んで、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}F_{S,T})\ast_A e_{S,T}=\rho\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)`), "。",
      ]),
      paragraph(["（ハ）", math(String.raw`a\in A`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\ast_A(\rho\ast_A a)
&=(1_{\mathbb{C}}\cdot_{\mathbb{C}}\rho)\ast_A a
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(\rho\cdot_{\mathbb{C}}1_{\mathbb{C}})\ast_A a
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Psi(F+_B G)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(F+_B G)_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(F_{S,T}+_{\mathbb{C}}G_{S,T})\ast_A e_{S,T}\right)
&&\left(\because\ \text{行列の和の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)+_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A e_{S,T}\Bigr)\right)
&&\left(\because\ \text{各}\ S\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)\right)+_A\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A e_{S,T}\Bigr)\right)
&&\left(\because\ \lambda_S:=1_{\mathbb{C}}\ \text{として右辺から左辺へ読む。}\blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=\Psi(F)+_A\Psi(G)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right),\\[4pt]
\Psi(\rho\ast_B F)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(\rho\ast_B F)_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}F_{S,T})\ast_A e_{S,T}\right)
&&\left(\because\ \text{行列のスカラー倍の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\rho\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)\right)
&&\left(\because\ \text{各}\ S\ \text{で（ロ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}1_{\mathbb{C}})\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)
&&\left(\because\ \text{各}\ S\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\rho\ast_A\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)\right)
&&\left(\because\ \lambda_S:=1_{\mathbb{C}}\ \text{として右辺から左辺へ読む。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\rho\ast_A\Psi(F)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right).
\end{aligned}`),
      paragraph([
        "二つの等式は線型写像の二つの条件（", ref("def_linear_map"), "）である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は、行列単位を行列単位にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`e_{S,T}`), " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものとし、", math(String.raw`E_{S,T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を行列単位（",
        ref("def_matrix_unit"), "）とする。すべての ", math(String.raw`S,T\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(E_{S,T})=e_{S,T}`),
    ],
    proof: [
      paragraph([
        "和はすべて ", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), " の上の和、", math(String.raw`\delta`), " は ",
        math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。準備として次の三つが成り立つ。",
      ]),
      paragraph(["（イ）", math(String.raw`S',T'\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
(E_{S,T})_{S',T'}\ast_A e_{S',T'}
&=\bigl(\delta_{S,S'}\cdot_{\mathbb{C}}\delta_{T,T'}\bigr)\ast_A e_{S',T'}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\bigl(\delta_{T,T'}\cdot_{\mathbb{C}}\delta_{S,S'}\bigr)\ast_A e_{S',T'}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A e_{S',T'}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "（ロ）", math(String.raw`S'\in\mathcal{P}_M`), " について、", ref("claim_sum_over_finite_set_with_kronecker_delta_picks_term"), " を、主張の ", math(String.raw`x`), " に ",
        math(String.raw`T`), "、和の変数に ", math(String.raw`T'`), "、", math(String.raw`v_{T'}:=\delta_{S,S'}\ast_A e_{S',T'}`), " を当てて、",
        math(String.raw`\sum_{T'\in\mathcal{P}_M}\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A e_{S',T'}\bigr)=\delta_{S,S'}\ast_A e_{S',T}`), "。",
      ]),
      paragraph(["（ハ）", math(String.raw`S'\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\ast_A\bigl(\delta_{S,S'}\ast_A e_{S',T}\bigr)
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,S'}\bigr)\ast_A e_{S',T}
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{S,S'}\ast_A e_{S',T}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Psi(E_{S,T})
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T'\in\mathcal{P}_M}(E_{S,T})_{S',T'}\ast_A e_{S',T'}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T'\in\mathcal{P}_M}\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A e_{S',T'}\bigr)\right)
&&\left(\because\ \text{各}\ S',T'\ \text{で（イ）。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(\delta_{S,S'}\ast_A e_{S',T}\bigr)
&&\left(\because\ \text{各}\ S'\ \text{で（ロ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S'\in\mathcal{P}_M}\delta_{S,S'}\ast_A e_{S',T}
&&\left(\because\ \text{各}\ S'\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=e_{S,T}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S\text{、和の変数に}\ S'\text{、}v_{S'}:=e_{S',T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は、行列単位どうしの積を保つ" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、",
        math(String.raw`E_{S,T}\in B`), " を行列単位（", ref("def_matrix_unit"), "）、", math(String.raw`\cdot_B`), " を行列の積（", ref("def_matrices_indexed_by_finite_set"),
        "）とする。すべての ", math(String.raw`S,T,U,R\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi\bigl(E_{S,T}\cdot_B E_{U,R}\bigr)=\Psi(E_{S,T})\cdot_A\Psi(E_{U,R})`),
    ],
    proof: [
      paragraph([
        math(String.raw`\delta_{T,U}`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）、",
        math(String.raw`e_{S,T}`), " は ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(E_{S,T}\cdot_B E_{U,R}\bigr)
&=\Psi\bigl(\delta_{T,U}\ast_B E_{S,R}\bigr)
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=\delta_{T,U}\ast_A\Psi(E_{S,R})
&&\left(\because\ \Psi\ \text{はスカラー倍を保つ。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\right)\\
&=\delta_{T,U}\ast_A e_{S,R}
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit}\right)\\
&=e_{S,T}\cdot_A e_{U,R}
&&\left(\because\ \blkref{claim_product_of_matrix_unit_elements_of_split_clifford_algebra}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi(E_{U,R})
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は ℂ-代数の準同型である" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとする。",
        math(String.raw`\Psi`), " は ℂ-代数 ", math(String.raw`B`), "（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）から ℂ-代数 ", math(String.raw`A`),
        "（", ref("def_clifford_algebra"), "）への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B`), " の演算と単位元を ", math(String.raw`+_B,\ \cdot_B,\ \ast_B,\ 1_B`), " と書く（", ref("def_matrices_indexed_by_finite_set"), "）。",
        math(String.raw`B`), " の中の和は ", math(String.raw`U_{\mathrm{vec}}(B)`), "、", math(String.raw`A`), " の中の和は ", math(String.raw`U_{\mathrm{vec}}(A)`),
        "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合 ", math(String.raw`\mathcal{P}_M`), " の上の和である。", math(String.raw`e_{S,T}`), " は ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のもの、", math(String.raw`E_{S,T}\in B`), " は行列単位（", ref("def_matrix_unit"), "）、",
        math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`B`), " と ", math(String.raw`A`), " で元を左から・右から掛ける写像は線型写像である（", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_right_multiplication_in_algebra_is_linear_map"), "）。", math(String.raw`\Psi`), " は加法とスカラー倍を保つ（",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), "）ので、残りは乗法の単位元と乗法を保つことである。",
      ]),
      paragraph([
        "（イ）乗法の単位元。", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_sum_over_finite_set_with_kronecker_delta_picks_term"), " を、主張の ",
        math(String.raw`x`), " に ", math(String.raw`S`), "、和の変数に ", math(String.raw`T`), "、", math(String.raw`v_T:=e_{S,T}`), " を当てて、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}\delta_{S,T}\ast_A e_{S,T}=e_{S,S}`), " が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(1_B)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(1_B)_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}\delta_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A e_{S,S}
&&\left(\because\ \text{各}\ S\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=1_A
&&\left(\because\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right).
\end{aligned}`),
      paragraph([
        "（ロ）行列単位を左に置いた積。", math(String.raw`S,T\in\mathcal{P}_M`), " と ", math(String.raw`G\in B`), " について次が成り立つ。和の変数は ",
        math(String.raw`S',T'\in\mathcal{P}_M`), " と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(E_{S,T}\cdot_B G\bigr)
&=\Psi\left(E_{S,T}\cdot_B\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B E_{S',T'}\Bigr)\right)\right)
&&\left(\because\ F:=G\text{、}X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right)\\
&=\Psi\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B\bigl(E_{S,T}\cdot_B E_{S',T'}\bigr)\Bigr)\right)
&&\left(\because\ f:=E_{S,T}\cdot_B\bullet\text{。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\Psi\bigl(E_{S,T}\cdot_B E_{S',T'}\bigr)\Bigr)
&&\left(\because\ f:=\Psi\text{。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\bigl(\Psi(E_{S,T})\cdot_A\Psi(E_{S',T'})\bigr)\Bigr)
&&\left(\because\ \text{各}\ S',T'\ \text{で}\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units}\text{。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\Psi(E_{S,T})\cdot_A\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\Psi(E_{S',T'})\Bigr)\right)
&&\left(\because\ f:=\Psi(E_{S,T})\cdot_A\bullet\ \text{として右辺から左辺へ読む。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B E_{S',T'}\Bigr)\right)
&&\left(\because\ f:=\Psi\ \text{として右辺から左辺へ読む。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi(G)
&&\left(\because\ F:=G\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
      paragraph(["（ハ）乗法。", math(String.raw`F,G\in B`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(F\cdot_B G\bigr)
&=\Psi\left(\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)\right)\cdot_B G\right)
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right)\\
&=\Psi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B\bigl(E_{S,T}\cdot_B G\bigr)\Bigr)\right)
&&\left(\because\ f:=\bullet\cdot_B G\text{。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\Psi\bigl(E_{S,T}\cdot_B G\bigr)\Bigr)
&&\left(\because\ f:=\Psi\text{。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\bigl(\Psi(E_{S,T})\cdot_A\Psi(G)\bigr)\Bigr)
&&\left(\because\ \text{各}\ S,T\ \text{で（ロ）。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\Psi(E_{S,T})\Bigr)\right)\cdot_A\Psi(G)
&&\left(\because\ f:=\bullet\cdot_A\Psi(G)\ \text{として右辺から左辺へ読む。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)\right)\cdot_A\Psi(G)
&&\left(\because\ f:=\Psi\ \text{として右辺から左辺へ読む。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(F)\cdot_A\Psi(G)
&&\left(\because\ \blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
      paragraph([
        "加法を保つこと（", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), "）と（ハ）と（イ）により、", math(String.raw`\Psi`), " は ",
        math(String.raw`U_{\mathrm{ring}}(B)`), " から ", math(String.raw`U_{\mathrm{ring}}(A)`), " への環の準同型（", ref("def_ring_homomorphism"), "）であり、",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), " により ", math(String.raw`U_{\mathrm{vec}}(B)`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`),
        " への線型写像である。したがって ", math(String.raw`\Psi`), " は ℂ-代数の準同型である（", ref("def_complex_algebra_homomorphism"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_mutually_inverse_homomorphisms_heading",
    kind: "heading",
    level: 2,
    title: { text: "二つの準同型が互いに逆であること" },
    labels: [],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_on_matrix_unit_element",
    kind: "claim",
    title: { text: "行列環への準同型は、行列単位にあたる元を行列単位へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_on_matrix_unit_element"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`e_{S,T}`), " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のもの、", math(String.raw`E_{S,T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を行列単位（",
        ref("def_matrix_unit"), "）とする。すべての ", math(String.raw`S,T\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi(e_{S,T})=E_{S,T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。", math(String.raw`y^{S}_t`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`z^{T}_t`), " と ", math(String.raw`w^{T}_k`), " を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`x_i`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"),
        " のものとする。", math(String.raw`t\in\{1,\dots,M\}`), " について、", math(String.raw`B`), " の元 ", math(String.raw`Y_t`), " を ", math(String.raw`t\in S`), " なら ",
        math(String.raw`Y_t:=c_t`), "、", math(String.raw`t\notin S`), " なら ", math(String.raw`Y_t:=1_B`), " と定め、", math(String.raw`Z_t`), " を ",
        math(String.raw`t\in T`), " なら ", math(String.raw`Z_t:=c_t^{\mathsf T}`), "、", math(String.raw`t\notin T`), " なら ", math(String.raw`Z_t:=1_B`),
        " と定める（", math(String.raw`c_t`), " は ", ref("def_creation_operator_matrix"), "、", math(String.raw`c_t^{\mathsf T}`), " は ",
        ref("def_annihilation_operator_matrix"), " のもの）。", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`W_k:=Z_{M+1-k}`), " と置く。準備として次の四つが成り立つ。",
      ]),
      paragraph(["（イ）", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`\Phi(y^{S}_t)=Y_t`), " と ", math(String.raw`\Phi(z^{T}_t)=Z_t`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(y^{S}_t)
&=\Phi(a^{\dagger}_t)
&&\left(\because\ t\in S\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\right)\\
&=c_t
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right)\\
&=Y_t
&&\left(\because\ t\in S\ \text{のときの}\ Y_t\ \text{の定め方}\right),\\[4pt]
\Phi(y^{S}_t)
&=\Phi(1_A)
&&\left(\because\ t\notin S\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\right)\\
&=1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=Y_t
&&\left(\because\ t\notin S\ \text{のときの}\ Y_t\ \text{の定め方}\right),\\[4pt]
\Phi(z^{T}_t)
&=\Phi(a_t)
&&\left(\because\ t\in T\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=c_t^{\mathsf T}
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right)\\
&=Z_t
&&\left(\because\ t\in T\ \text{のときの}\ Z_t\ \text{の定め方}\right),\\[4pt]
\Phi(z^{T}_t)
&=\Phi(1_A)
&&\left(\because\ t\notin T\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=Z_t
&&\left(\because\ t\notin T\ \text{のときの}\ Z_t\ \text{の定め方}\right).
\end{aligned}`),
      paragraph(["さらに ", math(String.raw`k\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(w^{T}_k)
&=\Phi(z^{T}_{M+1-k})
&&\left(\because\ \blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=Z_{M+1-k}
&&\left(\because\ \text{（イ）}\right)\\
&=W_k
&&\left(\because\ W_k\ \text{の置き方}\right).
\end{aligned}`),
      paragraph(["（ロ）", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(x_i)
&=\Phi\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=\Phi(a_i)\cdot_B\Phi(a^{\dagger}_i)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=c_i^{\mathsf T}\cdot_B c_i
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\text{、}\blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph(["（ハ）三つの番号順の積の像。"]),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(a^{\dagger}_S\bigr)
&=\Phi\left(\prod_{A,\,t=1}^{M}y^{S}_t\right)
&&\left(\because\ \blkref{def_ordered_product_of_selected_creation_generators}\right)\\
&=\prod_{B,\,t=1}^{M}\Phi(y^{S}_t)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,t=1}^{M}Y_t
&&\left(\because\ \text{各}\ t\ \text{で（イ）。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right),\\[4pt]
\Phi(P)
&=\Phi\left(\prod_{A,\,i=1}^{M}x_i\right)
&&\left(\because\ \blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=\prod_{B,\,i=1}^{M}\Phi(x_i)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,i=1}^{M}\bigl(c_i^{\mathsf T}\cdot_B c_i\bigr)
&&\left(\because\ \text{各}\ i\ \text{で（ロ）。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right)\\
&=E_{\emptyset,\emptyset}
&&\left(\because\ \blkref{claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit}\right),\\[4pt]
\Phi(a_T)
&=\Phi\left(\prod_{A,\,k=1}^{M}w^{T}_k\right)
&&\left(\because\ \blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=\prod_{B,\,k=1}^{M}\Phi(w^{T}_k)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,k=1}^{M}W_k
&&\left(\because\ \text{各}\ k\ \text{で（イ）の後の等式。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right).
\end{aligned}`),
      paragraph(["（ニ）", math(String.raw`E_{S,\emptyset}`), " に ", math(String.raw`E_{\emptyset,\emptyset}`), " を右から掛けても変わらない。"]),
      displayMath(String.raw`\begin{aligned}
E_{S,\emptyset}\cdot_B E_{\emptyset,\emptyset}
&=\delta_{\emptyset,\emptyset}\ast_B E_{S,\emptyset}
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=1_{\mathbb{C}}\ast_B E_{S,\emptyset}
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=E_{S,\emptyset}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi(e_{S,T})
&=\Phi\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\Phi\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\Phi\bigl(a^{\dagger}_S\bigr)\cdot_B\Phi(P)\Bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B\Phi(P)\Bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \text{（ハ）の一つ目}\right)\\
&=\left(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B E_{\emptyset,\emptyset}\right)\cdot_B\Phi(a_T)
&&\left(\because\ \text{（ハ）の二つ目}\right)\\
&=\left(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B E_{\emptyset,\emptyset}\right)\cdot_B\Bigl(\prod_{B,\,k=1}^{M}W_k\Bigr)
&&\left(\because\ \text{（ハ）の三つ目}\right)\\
&=E_{S,\emptyset}\cdot_B\Bigl(\prod_{B,\,k=1}^{M}W_k\Bigr)
&&\left(\because\ y_t:=Y_t\text{。}\blkref{claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit}\right)\\
&=\bigl(E_{S,\emptyset}\cdot_B E_{\emptyset,\emptyset}\bigr)\cdot_B\Bigl(\prod_{B,\,k=1}^{M}W_k\Bigr)
&&\left(\because\ \text{（ニ）}\right)\\
&=E_{S,\emptyset}\cdot_B\left(E_{\emptyset,\emptyset}\cdot_B\Bigl(\prod_{B,\,k=1}^{M}W_k\Bigr)\right)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=E_{S,\emptyset}\cdot_B E_{\emptyset,T}
&&\left(\because\ z_t:=Z_t\text{、}w_k:=W_k\text{。}\blkref{claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices}\right)\\
&=\delta_{\emptyset,\emptyset}\ast_B E_{S,T}
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=1_{\mathbb{C}}\ast_B E_{S,T}
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=E_{S,T}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型のあとに行列環への準同型を合成すると、恒等写像になる" },
    labels: ["claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", math(String.raw`\Psi`), " を ",
        ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と書く。すべての ", math(String.raw`F\in B`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi\bigl(\Psi(F)\bigr)=F`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`\Phi`), " は ℂ-代数の準同型なので、", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像である（", ref("def_complex_algebra_homomorphism"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。", math(String.raw`e_{S,T}`), " は ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(\Psi(F)\bigr)
&=\Phi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A e_{S,T}\Bigr)\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B\Phi(e_{S,T})\Bigr)
&&\left(\because\ f:=\Phi\text{。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)
&&\left(\because\ \text{各}\ S,T\ \text{で}\ \blkref{claim_homomorphism_to_matrix_algebra_on_matrix_unit_element}\text{。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=F
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements",
    kind: "claim",
    title: { text: "生成作用素の行列の一つの列の成分を係数にした、行列単位にあたる元の和" },
    labels: ["claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i`), " を生成作用素の行列（",
        ref("def_creation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " と ", math(String.raw`T\in\mathcal{P}_M`), " について、",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A e_{S,T}=a^{\dagger}_i\cdot_A e_{T,T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`a^{\dagger}_T`), " は ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_T`), " は ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"),
        " のもの、", math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`i\notin T`), " と ", math(String.raw`i\in T`), " のどちらか一方だけが成り立つ（", ref("def_power_set_of_first_m_positive_integers"), "）。",
      ]),
      paragraph([
        math(String.raw`i\notin T`), " のとき。", math(String.raw`\sigma:=\varsigma(N_i(T))\in\mathbb{C}`), "（", ref("def_count_of_subset_elements_below_index"), "、",
        ref("def_sign_of_nonnegative_integer"), "）と置く。（イ）", math(String.raw`S\in\mathcal{P}_M`), " について ",
        math(String.raw`(c_i)_{S,T}\ast_A e_{S,T}=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A e_{S,T})`), " が成り立つ。", math(String.raw`S=T\cup\{i\}`),
        " のときと ", math(String.raw`S\neq T\cup\{i\}`), " のときに分ける。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\ast_A e_{S,T}
&=\sigma\ast_A e_{S,T}
&&\left(\because\ i\notin T\ \text{かつ}\ S=T\cup\{i\}\text{。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ T\cup\{i\}=S\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(c_i)_{S,T}\ast_A e_{S,T}
&=0_{\mathbb{C}}\ast_A e_{S,T}
&&\left(\because\ S\neq T\cup\{i\}\ \text{なので条件が成り立たない。}\blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ T\cup\{i\}\neq S\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph(["（ロ）右辺は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A e_{T,T}
&=a^{\dagger}_i\cdot_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\Bigl(a^{\dagger}_i\cdot_A\bigl(a^{\dagger}_T\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_T\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(\sigma\ast_A a^{\dagger}_{T\cup\{i\}}\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ i\notin T\text{。}\blkref{claim_creation_generator_times_ordered_creation_product_without_index}\right)\\
&=\Bigl(\sigma\ast_A\bigl(a^{\dagger}_{T\cup\{i\}}\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A\Bigl(\bigl(a^{\dagger}_{T\cup\{i\}}\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A e_{T\cup\{i\},T}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A e_{S,T}
&=\sum_{S\in\mathcal{P}_M}\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ \text{各}\ S\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sigma\ast_A e_{T\cup\{i\},T}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ T\cup\{i\}\text{、和の変数に}\ S\text{、}v_S:=\sigma\ast_A e_{S,T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=a^{\dagger}_i\cdot_A e_{T,T}
&&\left(\because\ \text{（ロ）}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in T`), " のとき。（ハ）", math(String.raw`S\in\mathcal{P}_M`), " について、条件「", math(String.raw`i\notin T`), " かつ ",
        math(String.raw`S=T\cup\{i\}`), "」が成り立たないので、", math(String.raw`(c_i)_{S,T}\ast_A e_{S,T}=0_{\mathbb{C}}\ast_A e_{S,T}=0_A`), " である（",
        ref("def_creation_operator_matrix"), "、", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。（ニ）", math(String.raw`y\in A`), " について ",
        math(String.raw`0_A\cdot_A y=0_A`), " である。右から ", math(String.raw`y`), " を掛ける写像が線型写像であり（", ref("claim_right_multiplication_in_algebra_is_linear_map"),
        "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A e_{S,T}
&=0_A
&&\left(\because\ \text{各}\ S\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=0_A\cdot_A a_T
&&\left(\because\ \text{（ニ）}\right)\\
&=\bigl(0_A\cdot_A P\bigr)\cdot_A a_T
&&\left(\because\ \text{（ニ）}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_T\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ i\in T\text{。}\blkref{claim_creation_generator_times_ordered_creation_product_with_index_is_zero}\right)\\
&=\Bigl(a^{\dagger}_i\cdot_A\bigl(a^{\dagger}_T\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i\cdot_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i\cdot_A e_{T,T}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型は、生成作用素の行列を生成作用素にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`a^{\dagger}_i`), " を ",
        ref("def_creation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(c_i)=a^{\dagger}_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_T`), "・", math(String.raw`a_T`), "・", math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。和はすべて ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), " の上の和である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(c_i)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ X:=Y:=\mathcal{P}_M\text{、}\lambda_{S,T}:=(c_i)_{S,T}\text{、}v_{S,T}:=e_{S,T}\text{。}\blkref{claim_interchange_of_double_sum_over_finite_sets}\right)\\
&=\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(a^{\dagger}_i\cdot_A e_{T,T}\bigr)
&&\left(\because\ \text{各}\ T\ \text{で}\ \blkref{claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a^{\dagger}_i\cdot_A\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A e_{T,T}\right)
&&\left(\because\ f:=a^{\dagger}_i\cdot_A\bullet\ \text{として右辺から左辺へ読む。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a^{\dagger}_i\cdot_A\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)\right)
&&\left(\because\ \text{各}\ T\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a^{\dagger}_i\cdot_A 1_A
&&\left(\because\ \text{和の変数を}\ T\ \text{と書いた}\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements",
    kind: "claim",
    title: { text: "消滅作用素の行列の一つの行の成分を係数にした、行列単位にあたる元の和" },
    labels: ["claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " と ", math(String.raw`S\in\mathcal{P}_M`), " について、",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}=e_{S,S}\cdot_A a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`a^{\dagger}_S`), " は ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_S`), " は ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"),
        " のもの、", math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`T\in\mathcal{P}_M`), " について ", math(String.raw`(c_i^{\mathsf T})_{S,T}=(c_i)_{T,S}`), " であり（", ref("def_annihilation_operator_matrix"),
        "）、", math(String.raw`(c_i)_{T,S}`), " は、", math(String.raw`i\notin S`), " かつ ", math(String.raw`T=S\cup\{i\}`), " なら ", math(String.raw`\varsigma(N_i(S))`),
        "、それ以外なら ", math(String.raw`0_{\mathbb{C}}`), " である（", ref("def_creation_operator_matrix"), "）。", math(String.raw`i\notin S`), " と ",
        math(String.raw`i\in S`), " のどちらか一方だけが成り立つ（", ref("def_power_set_of_first_m_positive_integers"), "）。",
      ]),
      paragraph([
        math(String.raw`i\notin S`), " のとき。", math(String.raw`\sigma:=\varsigma(N_i(S))\in\mathbb{C}`), "（", ref("def_count_of_subset_elements_below_index"), "、",
        ref("def_sign_of_nonnegative_integer"), "）と置く。（イ）", math(String.raw`T\in\mathcal{P}_M`), " について ",
        math(String.raw`(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A e_{S,T})`), " が成り立つ。", math(String.raw`T=S\cup\{i\}`),
        " のときと ", math(String.raw`T\neq S\cup\{i\}`), " のときに分ける。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}
&=(c_i)_{T,S}\ast_A e_{S,T}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=\sigma\ast_A e_{S,T}
&&\left(\because\ i\notin S\ \text{かつ}\ T=S\cup\{i\}\text{。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ S\cup\{i\}=T\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}
&=(c_i)_{T,S}\ast_A e_{S,T}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\ast_A e_{S,T}
&&\left(\because\ T\neq S\cup\{i\}\ \text{なので条件が成り立たない。}\blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ S\cup\{i\}\neq T\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph(["（ロ）右辺は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
e_{S,S}\cdot_A a_i
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\cdot_A a_i
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(a_S\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(\sigma\ast_A a_{S\cup\{i\}}\bigr)
&&\left(\because\ i\notin S\text{。}\blkref{claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index}\right)\\
&=\sigma\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_{S\cup\{i\}}\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A e_{S,S\cup\{i\}}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}
&=\sum_{T\in\mathcal{P}_M}\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A e_{S,T})
&&\left(\because\ \text{各}\ T\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sigma\ast_A e_{S,S\cup\{i\}}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S\cup\{i\}\text{、和の変数に}\ T\text{、}v_T:=\sigma\ast_A e_{S,T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=e_{S,S}\cdot_A a_i
&&\left(\because\ \text{（ロ）}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in S`), " のとき。（ハ）", math(String.raw`T\in\mathcal{P}_M`), " について、", math(String.raw`(c_i)_{T,S}`), " の条件「",
        math(String.raw`i\notin S`), " かつ ", math(String.raw`T=S\cup\{i\}`), "」が成り立たないので、",
        math(String.raw`(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}=(c_i)_{T,S}\ast_A e_{S,T}=0_{\mathbb{C}}\ast_A e_{S,T}=0_A`), " である（", ref("def_annihilation_operator_matrix"), "、",
        ref("def_creation_operator_matrix"), "、", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。（ニ）", math(String.raw`y\in A`), " について ",
        math(String.raw`y\cdot_A 0_A=0_A`), " である。左から ", math(String.raw`y`), " を掛ける写像が線型写像であり（", ref("claim_left_multiplication_in_algebra_is_linear_map"),
        "）、線型写像は零を零へ移すこと（", ref("claim_linear_map_sends_zero_to_zero"), "）による。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}
&=0_A
&&\left(\because\ \text{各}\ T\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A 0_A
&&\left(\because\ \text{（ニ）}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(a_S\cdot_A a_i\bigr)
&&\left(\because\ i\in S\text{。}\blkref{claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero}\right)\\
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=e_{S,S}\cdot_A a_i
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型は、消滅作用素の行列を消滅作用素にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(c_i^{\mathsf T})=a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`e_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_S`), "・", math(String.raw`a_S`), "・", math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。和はすべて ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), " の上の和である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(c_i^{\mathsf T})
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A e_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(e_{S,S}\cdot_A a_i\bigr)
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A e_{S,S}\right)\cdot_A a_i
&&\left(\because\ f:=\bullet\cdot_A a_i\ \text{として右辺から左辺へ読む。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\right)\cdot_A a_i
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=1_A\cdot_A a_i
&&\left(\because\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators",
    kind: "claim",
    title: { text: "分裂した二次空間の元の像は、生成作用素にあたる元と消滅作用素にあたる元の線型結合である" },
    labels: ["claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`f`), "、", math(String.raw`V`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、",
        math(String.raw`\gamma`), "、", math(String.raw`\mathrm{in}_1`), "、", math(String.raw`\mathrm{in}_2`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"),
        " のもの、", math(String.raw`a^{\dagger}_k`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_k`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`\beta^{w}_k:W\to\mathbb{C}`),
        " を ", math(String.raw`w`), " についての第 ", math(String.raw`k`), " 座標の写像（", ref("claim_coordinate_map_is_linear_form"), "）とする。すべての ",
        math(String.raw`x\in W`), " と ", math(String.raw`g\in W^{*}`), " について、", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）の中の線型結合（", ref("def_linear_combination"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\gamma\bigl((x,g)\bigr)=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\left(\sum_{k=1}^{M}g(w_k)\ast_A a_k\right)`),
    ],
    proof: [
      paragraph([
        "準備として、", math(String.raw`\gamma\circ\mathrm{in}_1:W\to U_{\mathrm{vec}}(A)`), " と ", math(String.raw`\gamma\circ\mathrm{in}_2:W^{*}\to U_{\mathrm{vec}}(A)`),
        " は線型写像である。", math(String.raw`\mathrm{in}_1`), " と ", math(String.raw`\mathrm{in}_2`), " が線型写像であり（", ref("claim_embedding_into_first_component_is_linear_map"),
        "、", ref("claim_embedding_into_second_component_is_linear_map"), "）、", math(String.raw`\gamma`), " が線型写像であり（", ref("claim_clifford_generator_map_is_linear_map"),
        "）、線型写像の合成は線型写像だからである（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma\bigl(\mathrm{in}_1(x)\bigr)
&=(\gamma\circ\mathrm{in}_1)(x)
&&\left(\because\ \text{合成の定義}\right)\\
&=(\gamma\circ\mathrm{in}_1)\left(\sum_{k=1}^{M}\beta^{w}_k(x)\cdot_W w_k\right)
&&\left(\because\ V:=W\text{、}n:=M\text{、}b:=w\text{。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A(\gamma\circ\mathrm{in}_1)(w_k)
&&\left(\because\ f:=\gamma\circ\mathrm{in}_1\text{。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A\gamma\bigl(\mathrm{in}_1(w_k)\bigr)
&&\left(\because\ \text{各}\ k\ \text{で合成の定義。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k
&&\left(\because\ \text{各}\ k\ \text{で}\ \blkref{def_creation_generator_of_split_clifford_algebra}\text{。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right),\\[4pt]
\gamma\bigl(\mathrm{in}_2(g)\bigr)
&=(\gamma\circ\mathrm{in}_2)(g)
&&\left(\because\ \text{合成の定義}\right)\\
&=(\gamma\circ\mathrm{in}_2)\left(\sum_{k=1}^{M}g(w_k)\cdot_{W^{*}}f_k\right)
&&\left(\because\ V:=W\text{、}n:=M\text{、}b:=w\text{。}\blkref{claim_dual_basis_spans_dual_space}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A(\gamma\circ\mathrm{in}_2)(f_k)
&&\left(\because\ f:=\gamma\circ\mathrm{in}_2\text{。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A\gamma\bigl(\mathrm{in}_2(f_k)\bigr)
&&\left(\because\ \text{各}\ k\ \text{で合成の定義。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A a_k
&&\left(\because\ \text{各}\ k\ \text{で}\ \blkref{def_annihilation_generator_of_split_clifford_algebra}\text{。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma\bigl((x,g)\bigr)
&=\gamma\bigl(\mathrm{in}_1(x)+_V\mathrm{in}_2(g)\bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=\gamma\bigl(\mathrm{in}_1(x)\bigr)+_A\gamma\bigl(\mathrm{in}_2(g)\bigr)
&&\left(\because\ \gamma\ \text{は加法を保つ。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\gamma\bigl(\mathrm{in}_2(g)\bigr)
&&\left(\because\ \text{準備の一つ目の等式}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\left(\sum_{k=1}^{M}g(w_k)\ast_A a_k\right)
&&\left(\because\ \text{準備の二つ目の等式}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity",
    kind: "claim",
    title: { text: "クリフォード代数から行列環への準同型のあとに行列環からクリフォード代数への準同型を合成すると、恒等写像になる" },
    labels: ["claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", math(String.raw`\Psi`), " を ",
        ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。すべての ", math(String.raw`a\in A`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi\bigl(\Phi(a)\bigr)=a`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。", math(String.raw`\Phi`), " は ", math(String.raw`A`), " から ", math(String.raw`B`), " への、",
        math(String.raw`\Psi`), " は ", math(String.raw`B`), " から ", math(String.raw`A`), " への ℂ-代数の準同型である（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "、", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "）。したがって合成 ", math(String.raw`\Psi\circ\Phi:A\to A`),
        " は ℂ-代数の準同型であり（", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）、", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像である（", ref("def_complex_algebra_homomorphism"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。恒等写像 ", math(String.raw`\mathrm{id}_A`), " も ℂ-代数の準同型である（", ref("claim_identity_map_is_algebra_homomorphism"), "）。",
        math(String.raw`\gamma(V)`), " は ", math(String.raw`A`), " を生成する（", ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）ので、",
        ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " を ", math(String.raw`\varphi:=\Psi\circ\Phi`), "、", math(String.raw`\psi:=\mathrm{id}_A`), "、",
        math(String.raw`X:=\gamma(V)`), " に当てれば、すべての ", math(String.raw`v\in V`), " について ", math(String.raw`(\Psi\circ\Phi)(\gamma(v))=\mathrm{id}_A(\gamma(v))`),
        " を示せば主張が従う。",
      ]),
      paragraph(["準備として、", math(String.raw`k\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
(\Psi\circ\Phi)\bigl(a^{\dagger}_k\bigr)
&=\Psi\bigl(\Phi(a^{\dagger}_k)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\Psi(c_k)
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right)\\
&=a^{\dagger}_k
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix}\right),\\[4pt]
(\Psi\circ\Phi)(a_k)
&=\Psi\bigl(\Phi(a_k)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\Psi(c_k^{\mathsf T})
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right)\\
&=a_k
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`v\in V`), " をとる。", math(String.raw`V=W\oplus W^{*}`), " の元は順序対なので、", math(String.raw`v=(x,g)`), " となる ", math(String.raw`x\in W`), " と ",
        math(String.raw`g\in W^{*}`), " がある（", ref("def_direct_sum_of_two_vector_spaces"), "）。", math(String.raw`\beta^{w}_k`), " は ",
        ref("claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Psi\circ\Phi)\bigl(\gamma((x,g))\bigr)
&=(\Psi\circ\Phi)\left(\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)\right)
&&\left(\because\ \blkref{claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators}\right)\\
&=(\Psi\circ\Phi)\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A(\Psi\circ\Phi)\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)
&&\left(\because\ \Psi\circ\Phi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A(\Psi\circ\Phi)(a^{\dagger}_k)\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A(\Psi\circ\Phi)(a_k)\Bigr)
&&\left(\because\ f:=\Psi\circ\Phi\ \text{を二つの線型結合に当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)
&&\left(\because\ \text{各}\ k\ \text{で準備。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\gamma\bigl((x,g)\bigr)
&&\left(\because\ \blkref{claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators}\right)\\
&=\mathrm{id}_A\bigl(\gamma((x,g))\bigr)
&&\left(\because\ \mathrm{id}_A\ \text{の定義。}\blkref{claim_identity_map_is_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph([
        "したがって ", ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " により ", math(String.raw`\Psi\circ\Phi=\mathrm{id}_A`), " であり、すべての ",
        math(String.raw`a\in A`), " について ", math(String.raw`\Psi(\Phi(a))=(\Psi\circ\Phi)(a)=\mathrm{id}_A(a)=a`), " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra",
    kind: "theorem",
    title: { text: "主定理：分裂した二次空間のクリフォード代数と行列環の同型" },
    labels: ["theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`W`), " を ℂ-線型空間、", math(String.raw`w_1,\dots,w_M`), " をその基底、", math(String.raw`f_1,\dots,f_M`),
        " を双対基底とし、", math(String.raw`V:=W\oplus W^{*}`), "、", math(String.raw`q((x,g)):=g(x)`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`),
        "、", math(String.raw`a^{\dagger}_i:=\gamma(\mathrm{in}_1(w_i))`), "、", math(String.raw`a_i:=\gamma(\mathrm{in}_2(f_i))`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"),
        "、", ref("def_creation_generator_of_split_clifford_algebra"), "、", ref("def_annihilation_generator_of_split_clifford_algebra"), " のものとし、",
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。",
      ]),
      paragraph([
        math(String.raw`\varphi:V\to B`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"), " の写像、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"), "）、", math(String.raw`a^{\dagger}_S`), "・", math(String.raw`a_T`), "・",
        math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・",
        ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`\Phi:A\to B`), " を、", math(String.raw`\Phi\circ\gamma=\varphi`), " を満たすただ一つの ℂ-代数の準同型（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "。", math(String.raw`\Phi(a^{\dagger}_i)=c_i`), "、", math(String.raw`\Phi(a_i)=c_i^{\mathsf T}`), " を満たす。", ref("claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix"), "、",
        ref("claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix"), "）、", math(String.raw`\Psi:B\to A`), " を、",
        math(String.raw`F\in B`), " に ", math(String.raw`\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A((a^{\dagger}_S\cdot_A P)\cdot_A a_T)\bigr)`),
        " を与える写像（", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "）とする。このとき次が成り立つ。",
      ]),
      list([
        [math(String.raw`\Phi`), " と ", math(String.raw`\Psi`), " はどちらも ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"],
        [
          "すべての ", math(String.raw`a\in A`), " について ", math(String.raw`\Psi(\Phi(a))=a`), " であり、すべての ", math(String.raw`F\in B`), " について ",
          math(String.raw`\Phi(\Psi(F))=F`), " である。",
        ],
      ]),
      paragraph([
        "したがって ", math(String.raw`\Phi`), " は全単射であり、その逆写像は ", math(String.raw`\Psi`), " である。すなわち ", math(String.raw`\Phi`), " と ", math(String.raw`\Psi`),
        " は互いに逆な ℂ-代数の準同型である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Phi`), " は ℂ-代数の準同型であり（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "）、", math(String.raw`\Psi`), " は ℂ-代数の準同型である（",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "）。", math(String.raw`\Psi(\Phi(a))=a`), " は ",
        ref("claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity"), "、", math(String.raw`\Phi(\Psi(F))=F`), " は ",
        ref("claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"), " である。",
      ]),
      paragraph([
        "単射であること。", math(String.raw`a,b\in A`), " が ", math(String.raw`\Phi(a)=\Phi(b)`), " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
a
&=\Psi\bigl(\Phi(a)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=\Psi\bigl(\Phi(b)\bigr)
&&\left(\because\ \Phi(a)=\Phi(b)\right)\\
&=b
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right).
\end{aligned}`),
      paragraph([
        "全射であること。", math(String.raw`F\in B`), " について、", math(String.raw`\Psi(F)\in A`), " は ", math(String.raw`\Phi(\Psi(F))=F`), " を満たす（",
        ref("claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"), "）。",
      ]),
      paragraph([
        "したがって ", math(String.raw`\Phi`), " は全単射である。", math(String.raw`\Phi`), " の逆写像を ", math(String.raw`\Phi^{-1}:B\to A`), "（", math(String.raw`\Phi^{-1}(F)`),
        " は ", math(String.raw`\Phi(a)=F`), " を満たすただ一つの ", math(String.raw`a\in A`), "）とすると、", math(String.raw`F\in B`), " について ", math(String.raw`\Psi(F)`),
        " は ", math(String.raw`\Phi(\Psi(F))=F`), " を満たすので、", math(String.raw`\Phi^{-1}(F)=\Psi(F)`), " である。すなわち ", math(String.raw`\Phi^{-1}=\Psi`), " である。",
      ]),
    ],
  },
]);
