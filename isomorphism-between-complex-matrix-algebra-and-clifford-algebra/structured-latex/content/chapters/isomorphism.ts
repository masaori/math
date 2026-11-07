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
]);
