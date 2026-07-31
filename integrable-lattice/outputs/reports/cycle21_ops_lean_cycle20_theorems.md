# cycle 21 / 運用: cycle 20 の新定理群を Lean で検算する（定理 L1・L4・K′・W3・W4・Y′）

対象: cycle 20 で得た新定理群（`docs/tasks/auto-loop-state.md` の cycle 21 step 3）。
**目的は証明の正しさではなく、主張が一意に読めるか・仮定が過不足ないかの検査**である
（cycle 17: 誤り 1 件／18: 誤り 2 件／19: 過剰仮定 2 件／20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件。
本サイクルで 6 サイクル連続になる）。

前提として読んだ一次情報:
`outputs/reports/cycle20_T3_cancellation_recursion.md`（補題 L0・L0′、定理 L1、系 L2・L3・L3′、定理 L4、定理 K′）、
`cycle20_T3_s_infinity_decision.md`（定理 W1、補題 W2、定理 W3、定理 W4、系 W5・W6・W7）、
`cycle20_T3_ell_equals_2.md`（命題 P1、補題 P2、定理 Y、定理 Y′、系 Y″、補題 Y1–Y4）、
`cycle20_ops_lean_cycle19_theorems.md`、`lean/README.md`、
本文 `structured-latex/content/009_theta_recursion.ts`（命題 R）・`009_s_infinity_decision.ts`（命題 K）。

---

## 0. 結論（先に置く）

| 検出 | 内容 | 状態 |
|---|---|---|
| **主張の欠陥 1 件（最大の成果）** | 定理 Y′ $(5.4)$ 第 3 行の但し書き「**および全ての場合の $n=1$**」は、そのままでは読めない。第 3 行は $\lambda_1$ を含むが **case A では $\lambda_1$ が定義されていない**。必要なのは case B かつ $\lambda_1=1$ の $n=1$ **だけ**で、case A については（$\lambda_1$ を $\lambda_0$ と読めば）第 1・2 行から**従う**＝冗長 | §1。**同 cycle の step 4 が本文へ移したので、日本語版・英語版の両方に入っている**（`005c_ell2_family.ts` の (G″4)）。訂正案は §1.4 |
| **証明の根拠が不十分 1 件** | 系 Y″ の証明の「実際 $n=1,2$ の 2 点で既に食い違う」は、$\Lambda$ を動かすと**偽**。case A$\alpha$ は $\Lambda=1$ の定理 X′ と $n=1,2$ の**両方で一致する**（$5,19$）。食い違うのは $n=3$（$61$ vs $55$） | §2。系 Y″ の**主張自体は正しい** |
| **記号の多義性 1 件** | 本文 命題 R の (R1) で、押し下げた族 $g_c$ の係数が**添字なしの $\mu$** と書かれている（$\mu_{c+\ell\gamma}$ であるべき） | §3.1。日本語版・英語版の両方（`009_theta_recursion.ts`）。**本文の修正が要る** |
| **主張の役割分担が読み取りにくい 1 件** | 本文 命題 K の (K3) は「$S_\infty$ を完全に決める」と書くが、決まるのは**点集合まで**で、$b$ には (K4) の重複度が要る。実際 $\ell=3$ の族で **$|S_\infty|=1$ なのに $b=2$**。また (K3) は $\gamma$ の走査範囲が有限であることを書かないまま $O(|S|^3)$ を主張している | §3.2 |
| **過剰仮定 2 件** | (1) 定理 L1 の 2（$s^*$ の存在）に「行列 $\bigl(\binom cs\bigr)$ の可逆性」は要らず、$C$ の最大元 1 つで済む（$\ell$ の素数性も体であることも不要、上界も $s^*\le\max C$ と鋭い）。(2) $(2.1)$ の係数取り出しに $c<\ell$ は要らない（要るのは $s<\ell$ だけ） | §4 |
| **食い違い無し** | 定理 Y′ の 4 つの閉形式は、**Matrix–Tree 定理による完全に独立な整数計算**（12 塔 × $n\le4$、48 件）と**全一致**（FAIL 0）。補題 L0（枝分解）・系 L2 の上界の達成・補題 W2 の (iii)⇒(iv)・定理 W3 の判定の決定可能性も主張どおり通った | §5・§6 |
| 検証 | `lake build` **8674 jobs** / `BUILD_EXIT=0`（cycle 20 は 8671）、`check-no-sorry.sh` で列挙した **196 個**の定理（cycle 20 は 156 個。今回 **40 個**追加）がすべて `sorryAx` 非依存 / `CHECK_EXIT=0` | §7 |

---

## 1. 検出した主張の欠陥: 定理 Y′ の「および全ての場合の $n=1$」は読めない

### 1.1 何が書いてあるか

`cycle20_T3_ell_equals_2.md` §5.2 の $(5.4)$ は 4 行の場合分けで、第 3 行の条件が

> $2n\,2^{n}+\lambda_1(2^{n}-1)\qquad(\text{B}:\ \lambda_1\ge2,\ \textbf{および全ての場合の } n=1)$

となっている。第 4 行は $(\text{B}:\lambda_1=1,\ n\ge2)$ である。

### 1.2 なぜ読めないか

$\lambda_1:=v_2(c_e)$（$c_e$ は case B の**偶側**の係数）は **case B でしか定義されていない**。
case A（$p',q'$ ともに奇）には偶側の係数が無いので $\lambda_1$ は存在せず、
「全ての場合の $n=1$」を case A に当てると**値が決まらない**。

### 1.3 実際に必要なのはどこか（Lean で分けた）

- **必要**: case B かつ $\lambda_1=1$ の $n=1$。第 4 行を $n=1$ に当てると
  `EllTwo.Bsat_one_eq_B_one_add`（$\text{第4行}(n{=}1)=\text{第3行}(\lambda_1{=}1,n{=}1)+2w$）より
  真値より $2w$ だけ大きい。$\lambda_1=1$ のときは必ず $w\ge1$
  （`EllTwo.w_ge_one_of_lam1_one`。report §2 の括弧書きの検算）なので、**必ずずれる**
  （`EllTwo.Bsat_ne_B_at_one`）。**この但し書きが無いと $(5.4)$ は偽になる。**
- **冗長**: case A。$\lambda_1$ を $\lambda_0$ と読み替えたときの第 3 行の $n=1$ の値は、
  第 1 行・第 2 行の $n=1$ の値と**一致する**
  （`EllTwo.Aalpha_one_eq_B_one`、`EllTwo.Abeta_one_eq_B_one`。後者は $\lambda_0$ について一様）。
  すなわち case A では但し書きは新しい情報を持たない。

**1 つの但し書きに「無いと偽になる場合」と「書かなくても従う場合」が混ざっており、
しかも後者は記号が未定義のまま書かれている。**

### 1.4 波及範囲（本文にも入っている）

本 step の作業中に、同 cycle の step 4（`33492ee`）が定理 Y′ を本文へ移した。
移された **命題 G″ の (G″4)**（`structured-latex/content/005c_ell2_family.ts`）は、
この但し書きを **そのまま** 持っている:

> `2n\,2^{n}+\lambda_1\,(2^{n}-1) & (\text{B}:\ \lambda_1\ge2,\ \text{および全ての場合の } n=1)`

英語版（`structured-latex-en/content/005c_ell2_family.ts`）も同じで、
`(\text{B}: \lambda_1\ge2, \text{and } n=1 \text{ in every case})` となっている。
**したがってこれは report だけの問題ではなく、本文（日英両方）の問題である。**
なお本文は直後に「第 4 行が $n\ge2$ に限られるのは打ち消しの条件 $v_2(a_e)=n-2$ が
$n=1$ では実現しないためであり、$n=1$ は第 3 行が与える」と補足しており、
**意図は読み取れる**が、case A では $\lambda_1$ が未定義であるという型の問題は残る。

### 1.5 訂正案（本 step では本文を触っていない。次の担当が反映すること）

第 3 行の条件を

> $(\text{B}:\ \lambda_1\ge2$、および $\text{B}$ かつ $\lambda_1=1$ の $n=1)$

とする。case A の $n=1$ については、必要なら本文に

> なお case A でも $\lambda_1$ を $\lambda_0$ と読めば $n=1$ の値は同じ式 $\mu\cdot3+4+\lambda_0$ で与えられる
> （第 1・2 行から従う）

と注記する（これは定理の場合分けではなく系である）。

---

## 2. 検出した「証明の根拠が不十分」: 系 Y″ の 2 点論法

### 2.1 何が書いてあるか

系 Y″ の証明は

> 定理 X′ の式は $n$ の線形項をもたないが、A$\alpha$ は $-6n$、A$\beta$ は $-2n$、B・$\lambda_1=1$ は $+2n$ をもつので
> 一致しない（$n\to$ 大で $2^n$ 以下の項を比べればよい。**実際 $n=1,2$ の 2 点で既に食い違う**）。

と書いている。

### 2.2 何が起きるか

$\Lambda$ を固定しないで比べると、**A$\alpha$ は $\Lambda=1$ の定理 X′ と $n=1,2$ の両方で一致する**:

| $n$ | A$\alpha$（$\mu=0$） | 定理 X′（$\Lambda=1$） |
|---|---|---|
| 1 | 5 | 5 |
| 2 | 19 | 19 |
| 3 | **61** | **55** |

（`EllTwo.Aalpha_eq_Xprime_at_one_two`、`EllTwo.Aalpha_ne_Xprime_at_three`。
後者は「$n=1$ で一致させると $\Lambda=1$ に決まり、その $\Lambda$ では $n=3$ で食い違う」という形で述べてある。）

A$\beta$（$\lambda_0=2$）と B・$\lambda_1=1$ については 2 点で足りる
（`EllTwo.Abeta_ne_Xprime_at_two`、`EllTwo.Bsat_ne_Xprime_at_two`）。**3 点が要るのは A$\alpha$ だけ**である。

### 2.3 これは主張の誤りではない

定理 X′ の $\Lambda$ は塔から決まる量（例外直線の $\lambda$ の総和）であり、
A$\alpha$（トーラス型）では $\Lambda=2$ なので $n=1$ で $6\neq5$ と既に食い違う。
**系 Y″ の主張は正しい。** 誤っているのは括弧内の根拠づけの一般性であり、
「$\Lambda$ が塔から決まっているから 2 点で足りる」という前提を書かずに
「2 点で既に食い違う」とだけ書いているために、$\Lambda$ を自由に動かす読み方では反証にならない。
**本文側（命題 G″ の (G″5)）はこの 2 点論法を採用しておらず、
「(G′3) の式が持たない $n$ の線形項をもつので一致しない」とだけ書いている**ので、本文は無傷である。
訂正が要るのは report §5.3 の括弧内だけで、$\Lambda$ が塔から決まる量であることを明示するか、
$n\le3$ で比較する形に直せばよい。

---

## 3. 本文（構造化テキスト）側で見つかった記述の問題

**本サイクルの指示により本文は一切編集していない。以下は次に本文を触る担当への申し送りである
（step 4 は本 step と並行して既に main へマージされているので、追加の修正として入れる必要がある）。**

### 3.1 命題 R の (R1): $g_c$ の係数が添字なしの $\mu$ になっている

`structured-latex/content/009_theta_recursion.ts` の (R1) の表示式は

```
g_c(y)=\sum_{\gamma\in\mathcal{G}_c}\mu\,(1+y)^{\gamma}
```

であるが、$\mathcal{G}_c$ は「第 0 桁が $c$ の $\gamma$ を $(\gamma-c)/\ell$ で押し下げた族」なので、
係数は押し下げる**前**の $\mu$、すなわち $\mu_{c+\ell\gamma}$ でなければならない。
現状は $\mu$ という記号が (R1) の直前で $\mu_\gamma$ として定義されているのに、
表示式では添字を落としているため、**どの係数を指すのか一意に読めない**。
英語版（`structured-latex-en/content/009_theta_recursion.ts`）も同じ表示である。

**訂正案**: $g_c(y)=\sum_{\gamma\in\mathcal{G}_c}\mu_{c+\ell\gamma}\,(1+y)^{\gamma}$。
根拠 report 側（§2.1 の $\nu_c$ の定義）は $\mu_i\,\delta_{(\gamma_i-c)/\ell}$ と正しく書いており、
**report は正しく、本文へ移す段で添字が落ちている**（cycle 18・20 と同型の事故の 3 回目）。

### 3.2 命題 K の (K3): 「$S_\infty$ を完全に決める」と $b$ の距離

(K3) は判定手続きが「$S_\infty$ を完全に決める」と述べ、(K6) が $b=\sum_i m_i$ を述べる。
Lean で (K3) の判定（補題 W2 の (iv)）を実装して走らせると、**出てくるのは $S_\infty$ の点集合だけ**で、
$b$ は出てこない。実例:

| 例 | $\bar{\tilde E}$ | 判定を通る方向 | $b$ |
|---|---|---|---|
| $\ell=2$ トーラス（`SInfinity.torus_Sinf_candidates`） | $(z+w)(zw+1)$ | $(1,1)$ と $(1,-1)$ の 2 方向 | 2 |
| $\ell=3$、$(p,q)=(3,1)$（`SInfinity.fam3_Sinf_singleton`） | $-q'z(w-1)^2$ | $(1,0)$ の **1 方向だけ** | **2**（重複度 2） |

後者は **$|S_\infty|=1$ なのに $b=2$** である。(K6) は $\sum_i m_i$ と正しく書いているので誤りではないが、
(K3) の「完全に決める」を読んで $b$ まで決まると受け取られうる。
**(K3) の出力は点集合、$b$ を出すには (K4) の重複度計算が別に要る**ことを (K3) に明示するのが良い
（根拠 report §3.1 の手続きはステップ 4 で重複度を計算しており、report 側は正しい）。

もう 1 点、(K2) の (iv) は「すべての $\gamma\in\mathbb{Z}$」という**無限個の条件**として書かれている。
有限判定に落ちるのは「$S$ の像の外では和が空」だからで（`SInfinity.bucketVanish_iff`）、
本文はこの一行を書かないまま (K3) で $O(|S|^3)$ という計算量を主張している。
計算量の主張はこの有限性に依存するので、(K3) に「$\gamma$ は $S$ の像（高々 $|S|$ 個）を走ればよい」を入れるべきである。

---

## 4. 検出した過剰仮定

### 4.1 定理 L1 の 2 に「行列の可逆性」は要らない

本文 (R2) と report 定理 L1 の 2 の証明は

> $B=\bigl(\binom cs\bigr)_{0\le c,s\le\ell-1}$ は下三角かつ対角成分 $1$ なので可逆であり、
> $(\lambda_c)_{c\in C}\neq0$ から $(\sigma_s)\neq0$ が従う

と述べる。実際に効くのは **$C$ の最大元 $c_{\max}$ ただ 1 つ**である:
$s=c_{\max}$ と取れば、$c<s$ の項は $\binom cs=0$ で消え、$c>s$ の項は $C$ の外なので、

$$\sigma_{c_{\max}}=\sum_{c\in C}\lambda_c\binom{c}{c_{\max}}=\lambda_{c_{\max}}\neq0$$

（`sigma_eq_of_max`）。したがって

- **$\mathbb{F}_\ell$ が体であることも $\ell$ が素数であることも使わない**
  （`sigma_eq_of_max` は任意の**可換環**で成立する。Lean では $R$ を可変にして確認した）。
  $\ell$ の素数性が要るのは枝分解の側（Frobenius `one_add_X_pow_split`）だけである。
- 得られる上界は $s^*\le\max C$ で、**本文の $s^*\le\ell-1$ より鋭い**
  （$\max C\le\ell-1$ なので本文の主張は従う）。

行列の可逆性は正しい事実だが、**主張に必要な仮定より強い道具**である。

### 4.2 $(2.1)$ の係数取り出しに $c<\ell$ は要らない

report §2.2 の $(2.1)$（$[x^{\ell d+s}]f_\nu=\sum_{c\in C}\lambda_c\binom cs$）の議論が使うのは
「$0\le s\le\ell-1$ なら $\ell d+s<\ell(d+1)$」だけで、枝の添字 $c$ が $\ell$ 未満であることは使わない。
Lean では `coeff_branch_single` の仮定を $s<\ell$ と $0<\ell$ だけにして通した
（$c$ は自由変数。枝の番号として使う限り $c<\ell$ は自動的に満たされるので実害は無い）。

### 4.3 過剰仮定が見つからなかった箇所

- **補題 W2 の (iii) ⇒ (iv)**（`SInfinity.psi_eq_zero_of_dvd`）は
  $\langle u^\perp,u\rangle=0$ だけから出る。$u$ の原始性も $\ell$ の素数性も使わない。
  report は $u$ を原始ベクトルとしているが、それが要るのは (iv) ⇒ (iii) と $S_\infty$ との対応（定理 W1）の側である。
- **定理 Y′ の場合分け**は排反かつ網羅である（`EllTwo.caseA_or_caseB` / `not_caseA_and_caseB`）。
  必要な前提は「$p',q'$ が同時に偶でない」ことだけで、これは $\mu$ の定義から従う。

---

## 5. 定理 Y′ の独立検証（Matrix–Tree 定理・本サイクルで新規に実施）

report の検証（Step B1–B3）とは**別経路**で、$\ell=2$ の族の閉形式を検算した。

- 塔 $X_{2^n,2^n}$ を $(\mathbb{Z}/2^n)^2$ 上の Cayley 多重グラフとして直接構成し、
  ラプラシアンの余因子を **Bareiss 法（整数のみ、浮動小数点を使わない）** で厳密に計算して $\kappa_n$ を得る。
- 得られた $v_2(\kappa_n)$ を $(5.4)$ の 4 行と照合する。
- 走査: $(p,q)\in\{(1,1),(1,3),(1,2),(1,4),(3,5),(2,6),(3,4),(1,5),(5,7),(2,3),(4,6),(1,6)\}$、$n=1,2,3,4$。
  **48 件すべて一致（FAIL 0）**。4 つの場合すべてに標本があり、$n=1$ の例外（case B・$\lambda_1=1$）が
  実際に効いている塔が 4 つ含まれる。

スクリプトは `lean/scripts/ell2-matrix-tree-cycle21.py`、生ログは `lean/logs/ell2-matrix-tree-cycle21.log`。
**円分体も本サイクルの理論も使わない**（整数の行列式だけ）ので、report の 3 経路と独立である。

> 注: これは Lean の外の計算である。Kirchhoff の matrix-tree 定理は mathlib に無い（§6）ので、
> Lean 内で塔の値を独立計算する道は今も開いていない。

---

## 6. 形式化した内容

### 6.1 `IntegrableLattice/DigitBranchRecursion.lean`（定理 L1・系 L2）

| 定理 | 内容 |
|---|---|
| `sigma_eq_of_max` | **定理 L1 の 2 の核**（$\sigma_{\max C}=\lambda_{\max C}$。任意の可換環で成立） |
| `exists_sigma_ne_zero` / `exists_sigma_ne_zero_lt` | $s^*$ の存在と $s^*\le\ell-1$（実際は $\le\max C$） |
| `one_add_X_pow_split` / `branch_decomposition` | **補題 L0**（枝分解。$(1+x)^\ell=1+x^\ell$ だけで出る） |
| `coeff_branch_single` / `coeff_branch_sum` | **$(2.1)$**（$[x^{\ell d+s}]=\sum_c\lambda_c\binom cs$） |
| `coeff_branch_lt` | 次数 $<\ell d$ の係数はすべて $0$ |
| `exists_coeff_ne_zero_of_branches` | **定理 L1 の 3 の内容**（$\ell d\le\theta\le\ell d+\max C$。打ち消しでは消えない） |
| `L1_bound` | **定理 L1 の 4** の帰納段（$\ell d+s\le\ell^t-1$） |
| `geom_sum_one_add_X_pow_char` | **系 L2 の上界の達成**（$\sum_{j<\ell^t}(1+x)^j=x^{\ell^t-1}$） |

### 6.2 `IntegrableLattice/SInfinityDecision.lean`（補題 W2・定理 W3）

| 定理 | 内容 |
|---|---|
| `bucketVanish_iff` / `decidableBucketVanish` | **定理 W3 のステップ 3 が決定可能**であること（無限個の $\gamma$ → $S$ の像だけ） |
| `psiHom` / `psi_coeff` | $\bar\psi_u$（環準同型）と、その係数がちょうどバケツ和であること |
| `psi_chi_perp_sub_one` / `psi_eq_zero_of_dvd` | **補題 W2 の (iii) ⇒ (iv)** |
| `torus_diag` / `torus_anti` / `torus_not_e1` / `torus_Sinf_candidates` | $\ell=2$ トーラスで判定を `decide` で走らせ $S_\infty$ を得る |
| `fam3_e1` / `fam3_not_diag` / `fam3_Sinf_singleton` | 族 $\ell\mid p'$（$\ell=3$）。**$|S_\infty|=1$ なのに $b=2$** の witness |

### 6.3 `IntegrableLattice/EllTwoClosedForm.lean`（定理 Y′・系 Y″）

| 定理 | 内容 |
|---|---|
| `Aalpha_seq` / `Abeta_seq` / `Bsat_seq` / `B_seq` | report §5.2 注 5.1 の 4 数列（$n\le6$）の再計算 |
| `four_cases_distinct_at_three` | 4 数列が $n=3$ で相異なること |
| `caseA_or_caseB` / `not_caseA_and_caseB` | 場合分けが網羅かつ排反 |
| `lam0_ge_one` / `w_ge_one_of_lam1_one` | $\lambda_0\ge1$、および $\lambda_1=1\Rightarrow w\ge1$ |
| `Bsat_one_eq_B_one_add` / `Bsat_ne_B_at_one` | **§1 の欠陥（但し書きが必要な場合）** |
| `Aalpha_one_eq_B_one` / `Abeta_one_eq_B_one` | **§1 の欠陥（但し書きが冗長な場合）** |
| `B_eq_Xprime` | 系 Y″ の成立側 |
| `Aalpha_eq_Xprime_at_one_two` / `Aalpha_ne_Xprime_at_three` | **§2 の根拠不足の witness** |
| `Abeta_ne_Xprime_at_two` / `Bsat_ne_Xprime_at_two` | 他の 2 場合は 2 点で足りること |

---

## 7. 形式化しなかったもの（mathlib の欠落か、配線か）

**mathlib に無いと書く前に必ず検索した**（生ログ `lean/logs/mathlib-gap-survey-cycle21.log`。
3 段方式。走査 8264 ファイル、mathlib `520045ab14`）。

| 未形式化の主張 | 何が足りないか | 判定 |
|---|---|---|
| 定理 Y′ の**導出**（レベルごとの和 $S_m$、補題 Y4） | $\mathbb{Q}(\zeta_{2^m})$ の $2$ の上の素点での付値への配線。`IsCyclotomicExtension` は**実在する**（`Mathlib/NumberTheory/Cyclotomic/Basic.lean`） | **配線** |
| 塔の値 $\kappa_n$ の Lean 内での独立計算 | Kirchhoff の matrix-tree 定理／全域木数の公式。`matrixTree` 0 件、`kirchhoff` は内容・ファイル名とも **0 件**、`spanning tree` の 3 件は全域木の**存在**（Nielsen–Schreier / arborescence）で個数の公式ではない | **mathlib の欠落** |
| 定理 L4（終結式公式） | `Polynomial.resultant` は**実在する**（`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean`、`resultant_eq_prod_eval` もある）。足りないのは「$\ell$ が $\mathbb{Q}(\zeta_{\ell^M})$ で完全分岐」「$v_\ell(N(\alpha))=\varphi\,v_\ell(\alpha)$」の配線 | **配線** |
| 定理 K′（$(5.2)$ の総和） | 定理 L4 と補題 J1 の合成。前者が配線待ちなので同じ | **配線** |
| 補題 W2 の (iv) ⇒ (iii)（$\ker\bar\psi_u=(\chi^{u^\perp}-1)$） | Laurent 環の座標変換と剰余環の同定。`AddMonoidAlgebra` と `mapDomain_mul` は**実在する**（本ファイルで使用） | **配線** |
| 定理 W4（$j^*=m_u$） | $T$ 展開と $\bar\psi_u$ の合成。使う道具（`AddMonoidAlgebra`）は実在 | **配線** |
| 系 W7（$b\le\frac12\mathrm{per}(\mathrm{Newt})$） | Newton **多面体**（Ostrowski の加法性）と格子周長。`newtonPolytope` 0 件、語幹 `newton` の 7 ファイルはすべて Newton–Raphson 法・Newton 恒等式（`Mathlib/RingTheory/MvPolynomial/Symmetric/NewtonIdentities.lean` 等）で、**多面体としての Newton 多面体は無い**。`lattice polygon` も 0 件 | **mathlib の欠落** |
| 定理 L1 の $\mathbb{Z}_\ell$ 指数版（$\mathbb{F}_\ell[[x]]$ 上） | 本ファイルは指数を $\mathbb{N}$ に取った多項式版。`PowerSeries` と二項冪級数（`Mathlib/RingTheory/PowerSeries/Binomial.lean`）は**実在する** | **配線** |

**逆に、mathlib に在って使えたもの**: `Polynomial.coeff_one_add_X_pow`、`Polynomial.expand` /
`Polynomial.coeff_expand` / `coeff_expand_mul'`、`add_pow_expChar` / `add_pow_char_pow`、
`geom_sum_mul`、`Finset.sum_fiberwise_of_maps_to`、`Finset.max'_mem`、
`AddMonoidAlgebra.mapDomain_mul`（`MonoidAlgebra.mapDomain_mul` の `to_additive` 版）、
`Finset.decidableDforallFinset`。

---

## 8. 実行した検証（一次情報）

| 検証 | 結果 | ログ |
|---|---|---|
| `lake exe cache get` | `Completed successfully in 28592 ms!` / `CACHE_EXIT=0` | `lean/logs/cache-get-cycle21.log` |
| `lake build` | `Build completed successfully (8674 jobs).` / `BUILD_EXIT=0`（cycle 20 は 8671 jobs） | `lean/logs/build-cycle21-L1WY.log` |
| `bash lean/scripts/check-no-sorry.sh` | ソース中に `sorry`/`admit` なし。列挙した **196 個**の定理（cycle 20 は 156 個。今回 **40 個**追加）がすべて `sorryAx` 非依存。依存公理は `propext` / `Classical.choice` / `Quot.sound` のみ / `CHECK_EXIT=0` | `lean/logs/check-no-sorry-cycle21.log` |
| mathlib 欠落調査（3 段方式） | §7 の表 | `lean/logs/mathlib-gap-survey-cycle21.log` |
| 定理 Y′ の Matrix–Tree 照合（本サイクルで新規） | 12 塔 × $n\le4$ ＝ **48 件、FAIL 0** | `lean/logs/ell2-matrix-tree-cycle21.log` |
| `npm run check`（構造化 LaTeX） | `CHECK_EXIT=0`（生成物の鮮度・型検査・実行時検証・移行漏れ・負テスト 9 件・実行時検証テスト 13 件） | — |
| `validate-content.ts` | 未解決参照・未解決 targets なし / `VALIDATE_EXIT=0` | — |
| `verify-check-linkage.ts` | 参照されている対応はすべて生きている / `LINK_EXIT=0` | — |

**本文（`structured-latex/` と `structured-latex-en/`）は 1 文字も編集していない**（cycle 21 の担当分離）。
本 step のコミットは、並行して main へ入った step 4（`33492ee` / `0252e65`）の上へ rebase してある。

---

## 9. 本 step で自分が犯した誤り（隠さず記録する）

1. **`Finset.mem_antidiagonal` を取り違えた。** 同名の宣言が複数あり、
   `HasAntidiagonal` の方（`x∈antidiagonal n ↔ x.1+x.2=n`）ではない方を掴んで 2 回落ちた。
   `simp` に任せて解決した。
2. **`Polynomial.coeff_expand_mul` の引数順を間違えた**（`(n*p)` であって `(p*n)` ではない。
   使うべきは `coeff_expand_mul'`）。一次情報（`Mathlib/Algebra/Polynomial/Expand.lean`）を読んで直した。
3. **`AddMonoidAlgebra` が `Finsupp` の型シノニムだと思って書いた。**
   現行 mathlib（v4.32.1）では `AddMonoidAlgebra` は `coeff : M →₀ R` を持つ**構造体**である。
   記憶ではなく `Mathlib/Algebra/MonoidAlgebra/Defs.lean` を読んで直した。
   **「昔はこうだった」を根拠にしてはいけない**という、cycle 16 の偽陰性事故と同型の教訓である。
4. **mathlib 欠落調査の 3 段目で、フレーズ（`newton polygon`）をファイル名検索してしまった。**
   ファイル名にスペースは入らないので常に 0 件になり、判定の役に立たない。
   語幹 `newton` で取り直し、ログに「取り直した」ことを明記した（`mathlib-gap-survey-cycle21.log` 末尾）。
   **cycle 16 の教訓（3 段方式）を、方法だけ真似て中身を壊しかけた。**
5. **§2 の検出は、最初「report の言うとおり $n=1,2$ で食い違うはずだ」と思って
   Lean に書いたら証明が通らなかった**ことから見つかった。
   自分の想定が外れたときに report を疑い直したのが結果的に正しかった。

---

## 10. 新規性

**主張しない。** 本 step は既存の主張の検算であり、数学的に新しい内容は
§1–§3 の主張の欠陥・記述の問題の指摘と、§4 の仮定の整理だけである。
§5 の Matrix–Tree による照合も、既存の定理 Y′ の独立検証にすぎない。
