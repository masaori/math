# cycle 17 step 4 (T1 Reframe): 論文 001 の投稿前 既出性確認

作成日: 2026-07-31 / 対象: `outputs/papers/001_R_Lambda_duality/` の「未解決リスク」2 件
（寄与 (b)＝$\mathbb{Q}_p$ を使わない可算化の既出性、命題 T・V・W の既出性）

**これは文献調査であって証明ではない。既出なら「既出である」と書くのが成果である。**
本論文はそもそも新規性を主張していないので、既出だと分かっても瑕疵にはならない。

---

## 0. 結論サマリ（先に結論だけ）

| 対象 | 判定 | 根拠（本文を読んだもの） |
|---|---|---|
| 寄与 (b) 可算化 | **一般的な移動は確立した標準手法**（逆数学の「完備可分距離空間＝可算符号」／構成的代数の「完備化を使わずに Henselization を作る」）。ただし *p* 進付値・岩澤型増大則をこの流儀で扱った文献は、調べた範囲では見つからなかった | SEP「Reverse Mathematics」、Alonso García–Lombardi–Perdry arXiv:2202.06595 |
| 命題 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$） | **弱い形（$v_2$ が偶数）は既出**。等号 $2(L-1)$ そのものは見つからなかった | Mednykh–Mednykh arXiv:1902.05681 Theorem 5.1（§7.6 が本件のトーラス） |
| 命題 V（$v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$） | **$d=1$ は既知の古典（Gauss–Dold 合同）の帰結。既出とみなすべき**。多変数 $d\ge2$ の終結式合同の形は見つからなかった | Byszewski–Graff–Ward, Bull. LMS 53 (2021), Definition 2.1 と直後の記述 |
| 命題 W（非退化 $\mathbb{Z}_\ell^2$ 塔の閉形式） | **形（非退化⇒閉形式）は $d=1$ で既出**（Vallières 2021 Cor 5.7）。**$d=2$ の $\mu_1$ 係数の明示は、この分野の最新論文が「本論文では追わない」と明記している**。ただし **Monsky 1989（ASPM 17）が未取得で、そこに対応する定数 $\alpha$ が入っている可能性が残る（投稿前に必ず読むこと）** | Vallières arXiv:2006.14012、DuBose–Vallières alco.304 §7、Kataoka arXiv:2606.03579 §4.3、Wan arXiv:1712.02906 Thm 1.2 |

**どの対象についても「既出でないと確認した」とは書かない。** 以下はすべて「調べた範囲では見つからなかった」である。

---

## 1. 調査方法（何をどこまで調べたか）

| 手段 | 内容 |
|---|---|
| arXiv API（`export.arxiv.org/api/query`, abstract 検索） | `"reverse mathematics" AND "p-adic"` → **0 件**、`"reverse mathematics" AND "Hensel"` → **0 件**、`"reverse mathematics" AND "valued field"` → **0 件**、`"reverse mathematics" AND "field"` → 10 件（下記）、`"constructive" AND "p-adic"` → 30 件、`"computable" AND "p-adic"` → 30 件、`au:Mednykh AND "spanning trees"` → 12 件、`"critical group" AND "torus"` → 0 件 |
| zbMATH Open API | MSC 分類 × キーワードで交差検索: `cc:03F65 & p-adic`（4 件）、`cc:03D45 & p-adic`（6 件）、`cc:03F60 & p-adic`（1 件）、`cc:03F35 & p-adic` / `cc:03B30 & p-adic` / `cc:03F50 & p-adic` → **0 件**。ほか `ti:"spanning trees" & "p-adic valuation"` 等 |
| PDF 直取得＋`pdftotext -layout` | 下表の 9 本（全文をテキスト化して該当箇所を読んだ） |
| OEIS | A212800（$C_n\times C_n$ トーラスの全域木数）を text 形式で取得し、コメント・式を全部読んだ |
| SEP（Stanford Encyclopedia） | Reverse Mathematics の項（可算符号化の記述と、p 進への言及の有無） |
| 厳密整数計算 | 命題 T と Mednykh の定理の整合を $L=3,5,7,9,11,13$ で確認（Bareiss 法・Python 整数。**浮動小数点では $L\ge7$ で桁落ちして誤った結論が出る**ので使ってはならない） |

年代範囲は限定していない（1965 の Ershov から 2026 の Kataoka まで）。**MathSciNet は未使用**（購読が無い）。**Google Scholar は未使用**。

### 本文を取得できた文献 / できなかった文献

| 文献 | 取得 | どこまで読んだか |
|---|---|---|
| Vallières, *On abelian ℓ-towers of multigraphs*, arXiv:2006.14012 | ✅ | §5.5–5.6（Thm 5.6, **Cor 5.7**, 例 1–3） |
| McGown–Vallières, *… II*(sic: III), arXiv:2107.07639 | ✅ | Thm 6.1 と例 |
| Lei–Vallières, *The non-ℓ-part …*, arXiv:2201.05186 | ✅ | Thm 2.1, **Cor 2.2, Cor 2.3** |
| DuBose–Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Alg. Comb. 6(5) (2023), alco.304 | ✅ | Thm 6.2 と直後の注意、**§7 の例 (1)(2)** |
| Kataoka, arXiv:2606.03579 | ✅ | Thm 1.1、Table 1、**§4.3（λ₁, μ₁, ν を追わないという明記）**、参考文献 16 件すべて |
| Wan, *Class numbers and p-ranks in $\mathbb{Z}_p^d$-towers*, arXiv:1712.02906 | ✅ | §1（**Theorem 1.2 ＝ Monsky 1989 の引用形**） |
| Mednykh–Mednykh, *Complexity of the circulant foliation over a graph*, arXiv:1902.05681 | ✅ | **§5（Theorem 5.1）**、§7.6（離散トーラス $T_{n,m}=C_n\times C_m$） |
| Mednykh–Mednykh, arXiv:1711.00175 | ✅ | §5（circulant 版の同型定理） |
| Byszewski–Graff–Ward, *Dold sequences, periodic points, and dynamics*, Bull. LMS 53 (2021) 1263–1298 | ✅ | §1–§2（**Definition 2.1 と「$n=p$ なら $a_p\equiv a_1$」**）、Remark 3.7 |
| Alonso García–Lombardi–Perdry, *Elementary constructive theory of Henselian local rings*, MLQ 54 (2008) / arXiv:2202.06595 | ✅ | 冒頭・Introduction（構成的枠組みの宣言部） |
| **Monsky, *Fine estimates for the growth of $e_n$ in $\mathbb{Z}_p^d$-extensions*, ASPM 17 (1989), 309–330** | ❌ | **本文未確認**（Project Euclid は購読制限、DOI 10.2969/aspm/01710309。本文の内容は Wan による引用でしか知らない） |
| Haskell, *A transfer theorem in constructive p-adic algebra*, APAL (1992), DOI 10.1016/0168-0072(92)90033-V | ❌ | **本文未確認**（zbMATH のレビュー文のみ確認: Bishop 流の構成的 p 進数論、古典的妥当性と構成的妥当性の transfer 定理） |
| Harrison-Trainor, *Computable valued fields*, arXiv:1602.08408 | ❌ | **本文未確認**（abstract のみ） |
| Simpson, *Subsystems of Second Order Arithmetic* | ❌ | **本文未確認**（PDF を取得できず。可算符号化の一般事実は SEP で確認した） |
| Pelayo–Voevodsky–Warren, *A univalent formalization of the p-adic numbers* (2015) | ❌ | **本文未確認**（zbMATH メタデータのみ） |

---

## 2. 寄与 (b)（$\mathbb{Q}_p$ を使わない可算化）の既出性

### 2.1 何を主張しているのかを先に固定する

本論文の寄与 (b) は、本文 `paper_positioning` と `paper_remark_qp_motivation` の言い方では
「$\Lambda$ 側が $\mathbb{Q}_p$（非可算）を**必要としない**ことの精密化」であり、動機は
「**有限手続きと witness の水準まで降ろす**」ことである（$\Lambda$ の等号＝素因数分解の一致、
$\overline{\mathbb{Q}}$ の等号＝根の分離）。

### 2.2 見つかった先行（一般的な移動としては既出）

1. **逆数学における可算符号化は標準そのものである。** 二階算術で扱えるのは可算または可算符号で
   表せる対象に限られ、実数は急収束 Cauchy 列で符号化し、完備可分距離空間はその一般化として扱う
   （SEP「Reverse Mathematics」で確認。「$x\in\mathbb{R}$ と書くのは strictly speaking 記法の乱用」
   とまで書かれている）。$\mathbb{Q}_p$ は完備可分距離空間なので、この枠組みでは**そのまま可算符号で扱える**。
   したがって「$\mathbb{Q}_p$ を可算な言葉に置き換える」という一般的な移動自体は 1970 年代からの標準手法である。
   - ただし **SEP の本文は p 進数にも付値体にも一切言及していない**（確認済み）。
   - **重要な差**: 逆数学の符号化では実数・$p$ 進数の**等号は決定可能にならない**（$\Pi^0_1$）。
     本論文が $\Lambda$（素因数分解の一致）と $\overline{\mathbb{Q}}$（根の分離）に降ろすと**等号が決定可能になる**。
     この差は本物であり、寄与 (b) を書くならこの一点に絞るべきである（「$\mathbb{Q}_p$ を可算にした」ではなく
     「等号を決定可能な水準まで降ろした」）。
2. **構成的代数では「完備化という理想的対象を使わずに済ませる」ことがプログラムとして確立している。**
   Alonso García–Lombardi–Perdry, *Elementary constructive theory of Henselian local rings*
   （MLQ 54(3) (2008) 253–271 / arXiv:2202.06595）は、Henselian 局所環の**初等的**理論を与え、
   **Henselization を構成する**（完備化を経由しない）。冒頭で「すべての定理はアルゴリズム的内容をもつ」と宣言している。
   これは本論文の寄与 (b) と**同じ種類の移動**である（対象は $p$ 進付値そのものではなく Henselian 環）。
3. **Haskell, *A transfer theorem in constructive p-adic algebra*, APAL (1992)**（zbMATH レビューで確認、本文未確認）:
   Bishop 流で $p$ 進数論の一部を構成的に扱い、$\mathbb{Q}_p$ 上の一階文の古典的妥当性と構成的妥当性の
   transfer 定理を与える。**「$\mathbb{Q}_p$ の議論に構成的内容を与える」方向**であり、
   本論文の「$\mathbb{Q}_p$ に出ない」方向とは逆だが、最も近い既出である。
4. Macintyre, *Effective determination of the zeros of p-adic exponential functions* (1985)、
   Harrison-Trainor, *Computable valued fields* (2018)、Pelayo–Voevodsky–Warren (2015) が
   「$p$ 進を計算可能性・形式化の側から扱う」系統として存在する（いずれも本文未確認）。
5. 既に本文にある Ax–Kochen / Ershov（$\mathbb{Q}_p$ の一階理論は決定可能）は、本論文の動機が
   決定不能性ではないことの根拠として正しく機能している（cycle 15 で反映済み）。

### 2.3 見つからなかったもの（0 件の記録）

- **逆数学の文献で $p$ 進数・付値体を主題にしたものは見つからなかった。**
  arXiv abstract 検索で `"reverse mathematics"` × (`"p-adic"` / `"Hensel"` / `"valued field"`) はいずれも **0 件**。
  zbMATH の逆数学系 MSC（03B30, 03F35, 03F50）× `p-adic` も **0 件**。
  近いのは *Reverse Mathematics and Algebraic Field Extensions*（arXiv:1209.4944）、
  *Reverse mathematics of rings*（arXiv:2109.02037）、*A Reverse Mathematical Analysis of Hilbert's
  Nullstellensatz and Basis Theorem*（arXiv:2406.01336）で、いずれも体・環の代数構造が対象で
  付値体・$p$ 進は扱っていない（いずれも abstract のみ確認）。
- **岩澤型の増大則を「$\mathbb{Q}_p$ に出ずに」扱った文献は見つからなかった。**
  グラフの岩澤理論の主要論文（Vallières / McGown–Vallières / Lei–Vallières / DuBose–Vallières / Kataoka）は
  **すべて $\mathbb{Z}_p[[\Gamma]]$・$\mathbb{Q}_p$ 上で議論している**（本文を読んで確認）。
- **0 件は「無い」の証明ではない。** arXiv の abstract 検索は本文検索ではなく、逆数学の論文には
  「p-adic」を abstract に書かないものがありうる。zbMATH の MSC 交差も付与の揺れに弱い。
  MathSciNet を引けていない。

### 2.4 判定

**寄与 (b) を「可算化という発想」として書いてはならない。それは既出である。**
書けるのは「岩澤型増大則という具体的対象について、$\Lambda$/$\overline{\mathbb{Q}}$ まで降ろして
**等号を決定可能にした**」という一点であり、その一点についても「調べた範囲では見つからなかった」以上のことは言えない。

---

## 3. 命題 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）の既出性

### 3.1 見つかった先行（弱い形は既出）

**Mednykh–Mednykh, *Complexity of the circulant foliation over a graph*, arXiv:1902.05681, Theorem 5.1**
（本文を読んだ）:

> $H_n$ を circulant foliation とし、$\tau(n)$ をその全域木数とする。$Q(-1)$ の平方自由部分を $p$ とすると、
> ある整数列 $a(n)$ が存在して
> $1^{\circ}$ $n$ が奇: $\tau(n)=n\,\tau(H)\,a(n)^2$、
> $2^{\circ}$ $n$ が偶: $\tau(n)=p\,n\,\tau(H)\,a(n)^2$。

同論文 §7.6 が**離散トーラス $T_{n,m}=C_n\times C_m$ をこの枠組みの例として明示的に扱っている**
（$H=C_m$ とする circulant foliation）。$H=C_m$ では $\tau(H)=m$ なので、$n=m=L$ 奇に対して

$$\tau(L)=L\cdot L\cdot a(L)^2=L^2a(L)^2 .$$

したがって **$L$ 奇なら $v_2(\tau(L))=2\,v_2(a(L))$ は偶数**であることが既出である。
命題 T はこれより強く、$v_2(a(L))=L-1$ を主張している。

**厳密整数計算で両方を確認した**（Laplacian の余因子を Bareiss 法で整数計算。$L=3,5,7,9,11,13$）:

| $L$ | $v_2(\tau(L))$ | $2(L-1)$ | $\tau(L)/L^2$ は平方数か |
|---|---|---|---|
| 3 | 4 | 4 | ✅ |
| 5 | 8 | 8 | ✅ |
| 7 | 12 | 12 | ✅ |
| 9 | 16 | 16 | ✅ |
| 11 | 20 | 20 | ✅ |
| 13 | 24 | 24 | ✅ |

（**注意**: 同じ計算を倍精度浮動小数点でやると $L\ge7$ で桁落ちし、「命題 T が偽」という誤った結論が出る。
$\tau(7)$ は 25 桁ある。整数計算以外を使ってはならない。）

### 3.2 見つからなかったもの

- **$v_2(\tau(L))=2(L-1)$ そのものを述べた文献は見つからなかった。**
- OEIS **A212800**（$(n,n)$ トーラスグリッドの全域木数）の全コメント・全公式を読んだが、
  divisibility・$2$ 進付値についての記述は**一切ない**（漸近式 $\sim\Gamma(1/4)^4e^{4Gn^2/\pi}/(16\pi^3)$ と
  Kreweras 1978 への参照のみ）。
- 検索語を変えて複数回試した: `"spanning trees" + torus + divisib`、`"spanning trees" + congruence`、
  `"spanning trees" + "2-adic"`、`critical group / sandpile group + torus`、`Jacobian group + torus`、
  `"Cartesian product of cycles" + spanning trees + power of 2`。
  トーラスの critical group（Smith 標準形）を決定した論文は見つけられなかった
  （見つかるのは $C_3\times C_n$＝$\Delta$-graph（Mednykh–Mednykh–Yudin）や Möbius ladder など個別族）。

### 3.3 判定

**命題 T は「既出の弱い形（$v_2$ の偶数性）の強化」である。** 本文にその位置づけを書くべきである。
なお本論文の証明（不分岐性・Hensel・Newton 多角形）と Mednykh の証明（Galois 共役の対合による平方性）は
別の機構であり、Mednykh の定理から命題 T は従わない。

---

## 4. 命題 V（$v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$）の既出性

### 4.1 見つかった先行（$d=1$ は古典の帰結。既出とみなすべき）

**Byszewski–Graff–Ward, *Dold sequences, periodic points, and dynamics*, Bull. LMS 53 (2021) 1263–1298**
（open access。本文 §1–§2 を読んだ）:

> **Definition 2.1 (Dold sequence).** 整数列 $a=(a_n)$ が Dold 列であるとは
> $\sum_{d\mid n}\mu(n/d)\,a_d\equiv0 \pmod n$ が全ての $n\ge1$ で成り立つこと。
> …「特に $n=p$ が素数なら (1) は $a_p\equiv a_1 \pmod p$ という主張である。Fermat の小定理は
> 数列 $(a^n)$ が全ての素数で Dold 条件を満たすことを言っている（この合同は通常 Gauss に帰される）」

写像の周期点数列は Dold 列である（Dold 1983）。$d=1$ で $P$ が単位円上の 1 の冪根で消えないとき、
$a_L=\prod_{\xi^L=1}P(\xi)$ は対応する群自己同型の $L$ 周期点数（の符号違い）なので Dold 列であり、
$n=p^k$ に順に適用して

$$a_{p^n}\equiv a_{p^{n-1}}\equiv\cdots\equiv a_1=P(1) \pmod p$$

を得る。これは**命題 V（$d=1$）そのもの**である。したがって **$d=1$ の命題 V は既出（古典）とみなすべきである。**

数論側の対応物も古典である: $\mathbb{Z}_p$ 拡大で「$p\nmid h_0\Rightarrow p\nmid h_n$（全ての $n$）」は
岩澤による標準的事実である（Washington の教科書に収録されているが、**命題番号は未確認**なので本文に番号を書かないこと）。

### 4.2 見つからなかったもの／差分

- **多変数（$d\ge2$）の形、すなわち $a_{p^n}\equiv P(1,\dots,1)^{p^{dn}}\pmod p$ を終結式の言葉で述べた文献は
  見つからなかった。** ただし本論文の証明（Frobenius＋終結式の乗法性）は完全に初等的なので、
  folklore である可能性は依然として高い。
- グラフ側の類似は **Lei–Vallières arXiv:2201.05186 Corollary 2.3**（本文を読んだ）:
  $\mu=0$ の仮定の下で「全ての $n\ge1$ で $p\nmid\kappa_n$ $\iff$ $p\nmid\kappa_X$ かつ $g(T)$ の $\bmod\ p$ 還元が
  $\mu_{\ell^\infty}(k_\infty)\setminus\{1\}$ に根をもたない」。
  **これは $p\ne\ell$（塔の素数と付値の素数が違う）場合の判定**であって、命題 V（同じ素数）とは別物である。
  混同して引用してはならない。
- 本論文の証明の**射程は Dold より広い**: Dold 経由の議論は $a_L\ne0$（力学系としての解釈）を要するが、
  本論文の証明は $a_L=0$（$v_p=\infty$）を含めて無条件で、$d$ も任意である。この差は書いてよい。

### 4.3 判定

**命題 V は $d=1$ については既出（Gauss–Dold 合同の直接の帰結）。** 本文にそう書くべきである。
$d\ge2$ の形も「初等的で folklore の可能性が高い」以上のことは言えない。

---

## 5. 命題 W（非退化 $\mathbb{Z}_\ell^2$ 塔の閉形式）の既出性

命題 W の主張:
$$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu .$$

### 5.1 「非退化 ⇒ 閉形式」という形は $d=1$ で既出

**Vallières, arXiv:2006.14012, Corollary 5.7**（本文を読んだ）: bouquet 上の $\mathbb{Z}_\ell$ 塔で
$\ell\nmid(a_1^2+\cdots+a_t^2)$ なら $\mu_\ell=0,\ \lambda_\ell=1,\ \nu_\ell=0$、したがって
**全ての $n\ge1$ で $\mathrm{ord}_\ell(\kappa_n)=n$**。
「$\det L$ の低次係数が $\ell$ で割れないという有限計算可能な非退化条件を置くと閉形式が出る」という
**論法の形は完全に同型**である。命題 W はその $d=2$ 版である。本文にこの対応を書くべきである。

### 5.2 $d=2$ の低位項は「未確定」と最新論文が明記している

- **Kataoka, arXiv:2606.03579, §4.3**（本文を読んだ）:
  $\Gamma\simeq\mathbb{Z}_p^2$ のとき漸近式は $\mathrm{ord}_p(\kappa_{X_n})=\lambda np^n+\mu p^{2n}+\lambda_1n+\mu_1p^n+\nu$ の形になる、
  と書いたうえで
  > "Although $\lambda$ and $\mu$ are theoretically determined, identifying $\lambda_1$, $\mu_1$, and $\nu$
  > would require a more detailed analysis, **which we do not pursue in this paper**."

  すなわち**命題 W が与えている $\mu_1=k(\ell+1)/(\ell-1)$ は Kataoka には無い**。
  Kataoka の Theorem 1.1 も $\lambda_i,\mu_i,\nu$ の**存在**を主張するだけで明示式を与えていない。
- **DuBose–Vallières, alco.304, §7**（本文を読んだ）: $\mathbb{Z}_\ell^2$ 塔の例で
  $\mathrm{ord}_\ell(\kappa_n)=a\ell^{2n}+bn\ell^n+c\ell^n+dn+e$ の $a,\dots,e$ を**連続 5 層から 5 元連立一次方程式で数値的に解いている**だけで、
  > "we have not tried to prove that those numbers are the Greenberg coefficients"

  と明記している。**フィットであって証明ではない**（本プロジェクトが 3 回起こした事故と同じ構造の作業を、
  彼らは正直にフィットだと書いている）。
- 同 §6 の注記で「$X^d$ と $Y\!\cdot\!X^{d-1}$ の係数（＝$\mu$ と $\lambda$）については
  Cuoco–Monsky に明示式がある」と書かれている。裏を返すと**$X^{d-1}$ の係数（＝我々の $\mu_1$）の明示式は
  Cuoco–Monsky には無い**。

### 5.3 未確認の重大候補: Monsky 1989

**Wan, arXiv:1712.02906, Theorem 1.2**（本文を読んだ）は Monsky [Mo4]（＝*Fine estimates for the growth of
$e_n$ in $\mathbb{Z}_p^d$-extensions*, ASPM 17 (1989), 309–330）の結果を次の形で引用している:

> ある整数 $m_0,\ \ell_0$ と**実数 $\alpha$** が塔に依存して定まり、十分大きい $n$ で
> $$v_p(h_n)=(m_0p^n+\ell_0n+\alpha)p^{(d-1)n}+O(np^{(d-2)n}).$$

$d=2$ に置くと $v_p(h_n)=m_0p^{2n}+\ell_0np^n+\alpha p^n+O(n)$ となり、
**この $\alpha$ が命題 W の $k(\ell+1)/(\ell-1)$ に対応する位置**にある。
すなわち **Monsky 1989 は「$p^{n}$ の係数がある定数 $\alpha$ である」ところまで到達している**。
$\alpha$ が**明示公式**で与えられているのか存在のみなのかは、**本文を取得できていないので不明**である
（Project Euclid はアクセス制限。DOI 10.2969/aspm/01710309）。

補助的な事実として: **Kataoka (2026) の参考文献 16 件を全部確認したが、Monsky 1989 は引用されていない**
（引用されている Monsky は *On p-adic power series* (1981) のみ）。この分野の最新論文が引用していないことは、
Monsky 1989 に $\mu_1$ の明示式が無いことの**弱い傍証**にすぎず、確認の代わりにはならない。

### 5.4 本論文が既に正しく引用している事実の一次確認

DuBose–Vallières §7 例 (1)（$\ell=2$、bouquet に $\alpha(s_1)=(1,0),\alpha(s_2)=(0,1)$＝**$2^n\times2^n$ トーラス塔**）に
$$\mathrm{ord}_2(\kappa_n)=2\cdot n\cdot2^n+4\cdot2^n-6n-1\quad(1\le n\le10)$$
が載っていることを原文で確認した。本論文の命題 G(3)（退化 $\ell=2$ トーラス塔）の値が
「DuBose–Vallières 既出」だという既存の記述は**正しい**（ただし彼らの側は 10 層までの数値であって証明ではない）。

### 5.5 判定

- 命題 W の**形**（非退化⇒閉形式）は $d=1$ で既出（Vallières 2021 Cor 5.7）。
- 命題 W の**$\mu_1$ の明示式**は、Cuoco–Monsky・Kataoka・DuBose–Vallières のいずれにも無いことを本文で確認した。
- **ただし Monsky 1989 が未確認である以上、「文献に無い」と書いてはならない。**
  現行本文の「$\mu_1=k(\ell+1)/(\ell-1)$ の明示式は文献で見つけられなかったが、網羅調査ではないので
  新規性は主張しない」という書き方は**この時点で正しい**。そこに Monsky 1989 の名指しを足すべきである。

---

## 6. 論文 001 の本文へ反映すべき事項

| # | ブロック（ラベル） | 直すべき記述 | どう直すか |
|---|---|---|---|
| 1 | `paper_prop_T` の証明末尾 | 「文献調査は abstract のみで本文は未確認である」 | **弱い形が既出であることを書く**: Mednykh–Mednykh, *Complexity of the circulant foliation over a graph*, arXiv:1902.05681, Theorem 5.1（§7.6 が離散トーラス）により、奇 $L$ で $\tau(L)=L^2a(L)^2$（$a(L)\in\mathbb{Z}$）、ゆえに $v_2(\tau(L))$ が**偶数であることは既知**。命題 T はこれを $2(L-1)$ に確定させる強化である。等号そのものは調べた範囲で見つからなかった、と書く |
| 2 | `paper_prop_V` の証明末尾 | 「初等的であり folklore として既知である可能性が高い。文献本文での既出は確認できていない」 | **$d=1$ は既出だと明記する**: 周期点数列は Dold 列（Gauss 合同）であり、$n=p^k$ に適用すると $a_{p^n}\equiv a_1=P(1)\pmod p$ が直ちに従う（Byszewski–Graff–Ward, Bull. LMS 53 (2021) 1263–1298, Definition 2.1 と直後の記述）。数論側では「$\mathbb{Z}_p$ 拡大で $p\nmid h_0\Rightarrow p\nmid h_n$」として古典。**本論文の差分は「$a_L=0$ を許し、$d$ 任意で無条件」という点のみ**、と書く（教科書の命題番号は未確認なので書かない） |
| 3 | `paper_prop_W` の証明末尾 | 「$\mu_1=k(\ell+1)/(\ell-1)$ の明示式は文献で見つけられなかったが、網羅調査ではないので新規性は主張しない」 | 3 点を足す。(i) **Kataoka arXiv:2606.03579 §4.3 が $\lambda_1,\mu_1,\nu$ の同定を「本論文では追わない」と明記している**こと。(ii) **DuBose–Vallières alco.304 §7 は 5 層からの数値フィットであり「Greenberg 係数だと証明していない」と自ら書いている**こと。(iii) **Monsky, *Fine estimates for the growth of $e_n$ in $\mathbb{Z}_p^d$-extensions*, ASPM 17 (1989), 309–330 は本文未取得**であり、Wan arXiv:1712.02906 Thm 1.2 の引用形によれば同論文は $p^{(d-1)n}$ の係数として定数 $\alpha$ を得ているので、**そこに明示式がある可能性が残る**こと |
| 4 | `paper_prop_W` の「適用例」段落 | ℓ=2 の退化例の言及 | DuBose–Vallières §7 例 (1) が**まさにこの $2^n$ トーラス塔**で $\mathrm{ord}_2(\kappa_n)=2n2^n+4\cdot2^n-6n-1$（$1\le n\le10$）を挙げていることを原文で確認した旨を、命題 G(3) の既出性の根拠として明示する（彼らの側は 10 層の数値であって証明ではない、も併記） |
| 5 | `paper_remark_qp_motivation` | 「この立場の既出性は逆数学・構成的数学の本文では**確認していない**（投稿前に専門家確認を要する）」 | **調査結果で置き換える**。(i) 非可算対象を可算符号で扱うこと自体は逆数学の標準（実数＝急収束 Cauchy 列、完備可分距離空間はその一般化）であり、$\mathbb{Q}_p$ もその枠に収まるので**発想としては既出**。(ii) 構成的代数では完備化を経由せず Henselization を構成する仕事がある（Alonso García–Lombardi–Perdry, MLQ 54 (2008) 253–271）。(iii) $\mathbb{Q}_p$ を構成的に扱う仕事もある（Haskell, APAL 1992。**本文未確認**）。(iv) **本論文の差は「可算にした」ことではなく「等号が決定可能な水準（$\Lambda$ の素因数分解一致・$\overline{\mathbb{Q}}$ の根分離）まで降ろした」ことである**——逆数学の符号化では実数・$p$ 進数の等号は決定可能にならない。この 1 点に絞って書く |
| 6 | `paper_remark_scope`（本論文が主張しないこと） | 「命題 T・V・W についても新規性を主張しない。証明は初等的で、文献本文での既出は確認できていない」 | 「**確認できていない**」を「**命題 V は $d=1$ で既出、命題 T は弱い形が既出、命題 W は形が $d=1$ で既出**」に更新する。$\Lambda$ 側の未確認は Monsky 1989 の 1 本に絞られたことを書く |
| 7 | `refs.bib` | 新規エントリ | Mednykh–Mednykh (arXiv:1902.05681)、Byszewski–Graff–Ward (Bull. LMS 53 (2021) 1263–1298, doi:10.1112/blms.12531)、Vallières (arXiv:2006.14012, 既存エントリの note を「Cor 5.7 を本文で確認」に更新)、Lei–Vallières (arXiv:2201.05186)、Wan (J. Number Theory 203 (2019) 139–154)、Monsky ASPM 17 (1989) 309–330 (doi:10.2969/aspm/01710309, **note に「本文未取得」と明記**)、Alonso García–Lombardi–Perdry (MLQ 54(3) 2008, 253–271)、Haskell (APAL 1992, doi:10.1016/0168-0072(92)90033-V, **本文未確認**) |
| 8 | `notes.md`「未解決リスク」 | 2 件のリスク | 寄与 (b) は**閉じる**（既出の枠組みが特定でき、差分が 1 点に絞れた）。命題 T・V・W も**閉じる**が、**「Monsky 1989 の本文を投稿前に必ず読む」を新しい単独タスクとして残す**（$\mu_1$ の明示式が入っていれば命題 W の位置づけが変わる） |

---

## 7. 敵対的レビュー（自分の結論を反証しにいった結果）

1. **「命題 T の弱い形が既出」は本当か？** Mednykh の Theorem 5.1 は circulant foliation $H_n$ についてであり、
   トーラス $C_L\times C_L$ が本当にその枠に入るかを §7.6 で確認した（$H=C_m$ の場合として明示されている）。
   さらに $\tau(L)/L^2$ が平方数であることを $L=3,\dots,13$ で厳密整数計算により独立に確認した。→ 結論維持。
2. **「命題 V は Dold の帰結」は本当か？** Dold 合同は**周期点数**についての主張なので、$a_L$ が周期点数として
   解釈できないとき（$P$ が 1 の冪根で消えて $a_L=0$）は使えない。この場合を本論文の証明はカバーしている。
   したがって「完全に既出」ではなく「$a_L\ne0$ の場合は既出」が正しい。→ 結論を弱めて記載した。
3. **「Monsky 1989 に $\mu_1$ は無い」と言いたくなるが、言えない。** Kataoka が引用していないのは傍証にすぎない。
   Wan の引用形は $\alpha$ の**存在**しか読み取れないが、それは Wan が要約したからかもしれない。
   → 「未確認」と書き、投稿前タスクとして残した。
4. **「0 件」を根拠にしていないか？** arXiv abstract 検索の 0 件を「既出でない」の根拠には使っていない。
   検索手段の限界（本文検索でない、MathSciNet 未使用）を §1・§2.3 に明記した。
   cycle 6 の教訓（0/43 が 572 件で 4.5% の反例になった）を適用している。
5. **grep の偽陰性対策（cycle 16 step 4 の教訓）**: 各対象について検索語を 3 通り以上変え、
   arXiv・zbMATH・OEIS・SEP と手段も変えて試した。それでも見つからなかったものだけを「見つからなかった」と書いた。

---

## 8. 再現手順

```bash
mkdir -p /tmp/c17lit && cd /tmp/c17lit
for id in 2606.03579 2006.14012 2107.07639 2201.05186 1902.05681 1711.00175 1712.02906 2202.06595; do
  curl -sL -o $id.pdf "https://arxiv.org/pdf/$id"; pdftotext -layout $id.pdf $id.txt
done
curl -sL -o dubose.pdf "https://www.numdam.org/item/10.5802/alco.304.pdf"    # DuBose–Vallières（CC-BY）
curl -sL -o dold.pdf "https://eprints.whiterose.ac.uk/id/eprint/163332/8/…"  # Byszewski–Graff–Ward（open access）
curl -s "https://oeis.org/search?q=32,11664,42467328,1562500000000&fmt=text" # → A212800
# arXiv API 検索:  https://export.arxiv.org/api/query?search_query=abs:"..."+AND+abs:"..."
#   ※ http:// では応答が空。https:// を使うこと
# zbMATH API 検索: https://api.zbmath.org/v1/document/_search?search_string=cc:03F65%20%26%20any:%22p-adic%22
```

命題 T の厳密確認（浮動小数点を使わないこと）:
`sagemath/check/cycle17_T1_prior_art/`（`tau_v2_exact.py` / `tau_v2_exact.out` / `README.md`。
Laplacian の余因子を Bareiss 法で整数計算。SageMath 不要）。
このディレクトリはまだどのブロックからも参照されていないので、呼び出し元が `paper_prop_T` の
`verification` に追加すること（`structured-latex/` は本 step の担当範囲外）。
