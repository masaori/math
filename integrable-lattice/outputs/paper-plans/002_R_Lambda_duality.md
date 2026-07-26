# Paper plan 002: ℝ/Λ 双対 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性

トラック: **T1 Reframe**（`docs/themes.md`）。
状態: **据え置き**（`outputs/paper-plans/README.md` の G1–G6 ＋最終ゲート。判定は末尾「## 昇格判断」）。
起こし: cycle 12 step 1（`docs/tasks/auto-loop-state.md`）。cycle 1–11 の蓄積を統合。

---

## テーゼ（1文）

**整数重みの可積分格子模型に付随する整数スペクトル曲線 $P\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$ に対し、統計力学の自由エネルギー（アルキメデス素点での Mahler 測度、$\mathbb{R}$）と、有限サイズ Massieu 自由エントロピー $\Phi_L=\log|a_L|\in\Lambda$ の素因数構造（各 $p$ 進素点、$\Lambda$）は同一の $P$ の二つの素点における測度であり、前者は連続・非可算で Lehmer 問題のような未解決ギャップを抱えるのに対し、後者は $\mathbb{Q}_p$ を使わずに整数上の有限手続きへ還元でき、無条件に決定可能である。**

この「双対の決定可能性非対称」を、**両側とも既知理論に接地したうえで**、可算・決定可能・witness 付きの言葉へ書き換えるのが本稿の狙い（T1 Reframe）。**新しい可積分模型の厳密解ではない。**

---

## 1. 何が既知で、何が本プロジェクトの寄与か（最初に切り分ける）

誇張を避けるため、先に切り分けを置く。

| 項目 | 位置づけ | 根拠文献 / 本リポジトリの検証 |
|---|---|---|
| 自由エネルギー密度 ＝ アルキメデス Mahler 測度 $\log m(P)$ | **既知**（古典） | Lind–Schmidt–Ward（$\mathbb{Z}^d$ 作用の位相的エントロピー＝Mahler 測度） |
| Ising 自由エネルギーの Mahler 測度表示、特殊温度で楕円曲線 Hasse–Weil $L$、臨界点で Dirichlet $L$ | **既知** | arXiv:2407.19531 / Phys. Rev. E **110**, 054134 (2024) |
| $p$ 進トーラス上に零点をもたない $f$ について、Deninger の $p$ 進エントロピー $\hbar_p$ ＝ Besser–Deninger の $p$ 進 Mahler 測度 $m_p$ | **既知** | Deninger, arXiv:math/0608539, Theorem 1.1（仮定は同 Prop 2.4 c): $f=ct^\nu(1+pg)$） |
| その $\hbar_p, m_p$ は $\log_p$（$\log_p p=0$）で定義される量であり、**岩澤 $\mu_p$（付値の増大率）ではない** | **既知** | Ueki, arXiv:1702.03819, Remark 2.4「Besser and Deninger defined the purely $p$-adic Mahler measure with use of the $p$-adic log, which is different from ours」 |
| **1 変数**で、付値の増大率 $\mu_p$ ＝ $-\log_p\mathrm M_p(f)$ ＝ 係数 content の $p$ 進付値 | **既知** | Ueki, arXiv:1702.03819, Prop 2.7 / Thm 3.3 / Prop 3.6 / Prop 3.7 |
| グラフの $\mathbb{Z}_\ell$ 塔で $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$ | **既知** | McGown–Vallières III, arXiv:2107.07639, Theorem 6.1（仮定: $\chi(X)\neq0$、全導来グラフが連結） |
| グラフの $\mathbb{Z}_\ell^d$ 塔（$d\ge2$）では単一の線形成長率では書けず $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$（総次数 $\le d$） | **既知** | DuBose–Vallières, Algebraic Combinatorics **6** (2023) 1331–1346, Theorem A（仮定: 次数 1 の頂点なし、$\chi(X)\neq0$） |
| 一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$ の $v_p(a_{p^n})$ の増大則 | **未特定**（cycle 13 step 1 の調査で文献に見つけられず） | — |
| 円分 $\mathbb{Z}_p$ 拡大（アーベル体）で $\mu_p=0$ | **既知** | Ferrero–Washington (1979) |
| 全域木数の $\ell$ 進付値が岩澤 $\mu,\lambda$ と平行に振る舞う（グラフの岩澤理論） | **既知** | arXiv:2006.14012「On abelian $\ell$-towers of multigraphs」ほか（Vallières, McGown, Gonet 系） |
| $\mathbb{Z}^2$ トーラス全域木エントロピー $\to 4G/\pi$（$G$＝Catalan 定数） | **既知** | 古典（Kirchhoff の matrix-tree 定理＋格子和）。本リポジトリでは枠組みの妥当性検査に使用（`sagemath/check/cycle9_T1_spanning_tree/`） |
| 線形漸化列の $p$ 進付値の最終周期性、Pisano 型上界、LTE | **既知**（初等整数論・古典） | 線形漸化の $p$ 進解析、Skolem–Mahler–Lech、lifting-the-exponent |
| Lehmer 問題（$m(P)>1$ の最小値ギャップ）が未解決 | **既知**（未解決問題） | Lehmer (1933) |
| **(寄与 a)** 上記の両側を、**同一の整数曲線 $P$ の二素点**として並置し、統計力学量（自由エネルギー／有限サイズ Massieu $\Phi$）へ対応づける明示的な辞書 | 本プロジェクト（再框） | `outputs/reports/cycle4_T1_R_Lambda_mahler.md`, `cycle6_T1_padic_mahler_grounding.md`, root `docs/research/R-Lambda-duality/` |
| **(寄与 b)** $\Lambda$ 側が $\mathbb{Q}_p$（非可算）を**必要としない**ことの精密化＝可算・決定可能性の確立 | 本プロジェクト（再框） | `docs/research/R-Lambda-duality/` §3.1 |
| **(寄与 c)** $\Lambda$ 側の有限・初等・決定可能な顔を、**具体的な決定手続きと witness をもつ命題群**として確定 | 本プロジェクト（再框＋初等証明） | `outputs/candidates/D-U2_consolidated_proposition.md`, `outputs/reports/cycle8_T1_lte_proposition.md` |
| **(寄与 d)** 決定可能性非対称の集約（Lehmer は $\mathbb{R}$ 側固有。$\Lambda$ 側に対応する未解決連続ギャップは存在しない） | 本プロジェクト（既知定理の配置の地図） | `sagemath/check/cycle10_T3_lehmer/padic_analog_README.md` |

**寄与 (a)–(d) はいずれも既知数学の再框（reframe）である。**「可積分模型の新定理」「新しい深い数論」とは呼ばない。

---

## 2. 中核命題の候補（現状の確定度を明示する）

本稿のテーゼを担う中核命題は、次の **双対命題 D** である。ただし後述のとおり**一般性の範囲が未確定**であり、現時点では命題文として完成していない（G1 未達）。

### 双対命題 D（目標形、未完成）

$P\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$、$L$-周期点数
$$a_L=\prod_{z^L=1,\;w^L=1}P(z,w)\in\mathbb{Z}\quad(\text{トーラス零点は除く規約})$$
に対し、

- **($\infty$ 素点)** $\dfrac{1}{L^2}\log|a_L|\longrightarrow \log m(P)$（Mahler 測度＝位相的エントロピー＝自由エネルギー密度）。住処 $\mathbb{R}$。
- **($p$ 素点)** $\Phi_L=\log|a_L|\in\Lambda$ の $\ell_p$ 係数 $v_p(a_L)\in\mathbb{Z}_{\ge0}$ の増大が、$\mathbb{Z}$ 上の有限手続きで決定可能。

**($\infty$) 側の一般性は確定した**（cycle 13 step 1、`outputs/reports/cycle13_T1_padic_entropy_generality.md` §2）。文献本文で確認した3段:
エントロピー＝Mahler 測度は**無条件**（Lind–Schmidt–Ward, Invent. math. 101 (1990), Thm 3.1）。
周期点の増大率＝エントロピーは一般には**成立せず**、expansive（$\mathsf U(P)=\varnothing$）で成立（同 Thm 7.1）、
$\mathsf U(P)$ 有限で成立（Lind–Schmidt–Verbitskiy, arXiv:1108.4989, Thm 1.2）、
$\dim\mathsf U(P)\le d-2$（atoral）で成立（同 Thm 1.3）。本稿の 2 例（$5-(z+z^{-1})-(w+w^{-1})$ は $\mathsf U=\varnothing$、
離散ラプラシアンは $\mathsf U=\{(1,1)\}$）はいずれも射程内。ただし LSV は「周期成分の個数 $\mathsf P_\Gamma$ と
トーラス零点を除いた積 $a_L$ は $c_\Gamma(f)$ 因子だけずれる（漸近的には一致）」と明記しているので、
命題化の際はこの差を書くこと。

**($p$) 側は、旧稿の同一視が誤りであることが判明した**（同 report §3、cycle 13 step 1 で訂正）。
Deninger の $p$ 進エントロピー $\hbar_p$ と Besser–Deninger の $p$ 進 Mahler 測度 $m_p$ は
**岩澤対数 $\log_p$（$\log_p p=0$）** で定義されるため、$|{\rm Fix}|$ の $p$ 冪部分を最初から捨てており、
**$v_p$ の増大を測る量ではない**。さらに両者の定義域はほぼ排他的で、$\hbar_p,m_p$ が定義できる条件
（$P$ が $p$ 進トーラス上に零点をもたない ⟺ $P=ct^\nu(1+pg)$, Deninger arXiv:math/0608539 Prop 2.4）の下では
$v_p(a_L)=L^d\,v_p(c)$ と自明化する。一方 $\mu_p$ が非自明になるのは $P$ が $p$ 進トーラス上に零点をもつ場合で、
そこは $m_p$ が定義されない領域である（Ueki arXiv:1702.03819 Remark 2.4 が両者の相違を明記）。

**($p$) 側の残る未確定点**: 付値の増大を測る正しい量は $\log|\cdot|_p$ で定義される Ueki の $\mathrm M_p$ であり、
**1 変数**では $\mu_p=-\log_p\mathrm M_p=$ 係数 content の $p$ 進付値という同一視が確立している
（Ueki, Prop 2.7 / Thm 3.3 / Prop 3.6 / Prop 3.7）。しかし**2 変数・$\mathbb{Z}_p^2$ 塔**では、
グラフの場合ですら単一の線形成長率では書けず $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$（総次数 $\le d$）となる
（DuBose–Vallières, Algebraic Combinatorics 6 (2023), Thm A）。
一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$ の $v_p(a_{p^n})$ の増大則を述べた文献命題は**特定できていない**。
**この一般性が確定するまで命題 D を主定理として書けない（G1 未達）。**

### 現時点で厳密に確定している部分命題（すべて $\mathbb{R}$ 不使用・決定可能）

以下は $\Lambda$ 側の「有限・初等・決定可能な顔」であり、証明済みで機械検証の対象になる。

- **命題 A（$v_p$ の最終周期性）.** $T\in M_d(\mathbb{Z})$、$Z_N=\operatorname{Tr}T^N$、$p\nmid\det T$ とする。任意の切断 $k\ge1$ に対し $\min(v_p(Z_N),k)$ は $N$ について最終周期的で、その周期は $T^N \bmod p^k$ の最終周期 $\pi(p,k)$ を割る。$\pi(p,k)$ は有限モノイド $M_d(\mathbb{Z}/p^k)$ 上で決定可能。
  （証明: 有限集合上の鳩の巣。`outputs/reports/cycle3_T1_D-U2_rigorous.md`, `outputs/candidates/D-U2_consolidated_proposition.md`）
- **命題 B（$\pi(p,1)$ の精密公式）.** $\pi(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda):\lambda\in\overline{\mathbb{F}_p}^\times\ \text{相異固有値},\ p\nmid m_\lambda\}$（$m_\lambda$＝代数的重複度）。
  （証明: 指標の一次独立。cycle 7–8。）
- **命題 C（上界）.** $\pi(p,k)\mid p^{k-1}\pi(p,1)$（既知の Pisano 型上界）。**等号（Wall 型）は一般に成り立たない**（cycle 6 で六頂点 572 件中 4.5% の反例、Pell $p=13$ 等）。
- **命題 N（線形成長率）.** $v_p(Z_N)$ の $N$ 線形成長率は $\mu_{\min}(p)=\min_i v_p(\lambda_i)$＝$\chi_T$ の $p$ 進 Newton 多角形から定まる（整数係数の付値の下方凸包という有限組合せ手続き。固有値の個別構成も $\mathbb{Q}_p$ も不要）。
- **命題 L（1変数最小例の完全形, $P(z)=z-c$, $c\in\mathbb{Z}_{\ge2}$）.** $|a_L|=c^L-1$ について
  - $\infty$ 素点: $\lim_L \frac1L\log|a_L|=\log c=m(z-c)$。
  - $p$ 素点（$p$ 奇, $p\nmid c$, $d=\operatorname{ord}_p(c)$）: $v_p(c^L-1)=v_p(c^d-1)+v_p(L)$（$d\mid L$）、$0$（$d\nmid L$）。
  - $p=2$, $c$ 奇: $v_2(c^L-1)=v_2(c-1)$（$L$ 奇）、$v_2(c-1)+v_2(c+1)+v_2(L)-1$（$L$ 偶）。
  （LTE。初等証明・`decide` 可能。`outputs/reports/cycle8_T1_lte_proposition.md`）

- **命題 T（全域木数の 2 進付値, 証明済み）.** $\tau(L)$＝$L\times L$ トーラス $C_L\times C_L$ の全域木数とすると、
  **任意の奇数 $L\ge3$** に対し $v_2(\tau(L))=2(L-1)$。
  （証明: `outputs/reports/cycle13_T1_observation_T_settlement.md` §3。骨子は
  $\tau(L)=\prod_{j=1}^{L-1}(r_j^L+r_j^{-L}-2)=\prod_{j=1}^{L-1}(r_j^L-1)^2/r_j^L$（$r_j+r_j^{-1}=4-\zeta^j-\zeta^{-j}$）へ分解し、
  $L$ 奇より 2 が $\mathbb{Q}(\zeta_L)$ で不分岐であることを使って $r_j\equiv\zeta^j\ (\mathrm{mod}\ P)$ を取り、
  $r_j=\zeta^j(1+m_j)$ の $m_j$ が満たす 2 次式の Newton 多角形から $v(m_j)=1$、
  $v(L)=0$ による LTE 段で $v(r_j^L-1)=1$、総和して $2(L-1)$。使うのは Kirchhoff の matrix-tree 定理、
  Hensel の補題、Newton 多角形、二項展開のみで $\mathbb{R}$ を使わない。
  検証 `sagemath/check/cycle13_T1_tau_v2/`。**新規性は主張しない**（文献は abstract のみ確認、本文未確認。report §5）。）
  偶数 $L$ では成立しない（$L=2,\dots,14$ で $v_2=5,19,29,61,53,83,77$。証明が使う 2 条件が破れる。report §4）。

### 検証済みだが未証明の観察（証明ではないと明示する）

（現在、このカテゴリの項目はない。旧「観察 T」は cycle 13 step 3 で証明され、上の命題 T へ移した。）

---

## 3. 帰属台帳と $\mathbb{R}$ 脱出（選別基準 (i)(ii)）

本稿の中核命題が扱う各量の住処（共通 seed の台帳ではなく、**この企画で現れる量**について書く）。

| 量 | 記号 | 住処 | 決定可能性 |
|---|---|---|---|
| スペクトル曲線 | $P(z,w)=\det(wI-T(z))$ | $\mathbb{Z}[z^{\pm1},w^{\pm1}]$ | 係数比較で決定可能 |
| 転送行列 | $T\in M_d(\mathbb{Z})$、$T(z)\in M_{d_0}(\mathbb{Z}[z^{\pm1}])$ | $M_d(\mathbb{Z})$ / $M_{d_0}(\mathbb{Z}[z^{\pm1}])$ | 同上 |
| 周期点数・分配関数 | $a_L$, $Z_N=\operatorname{Tr}T^N$ | $\mathbb{Z}$ | 有限計算 |
| Massieu 自由エントロピー | $\Phi_L=\log|a_L|$ | $\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ | 等号＝素因数分解一致、順序＝整数比較 |
| $\ell_p$ 係数 | $v_p(a_L)\in\mathbb{Z}_{\ge0}$ | $\mathbb{Z}$ | $\mathbb{Z}$ 上の整除の有限手続き |
| 固有値・分散関係 | $\lambda_i$ | $\overline{\mathbb{Q}}$（可算） | 最小多項式・根分離（SageMath `QQbar`） |
| 周期 | $\pi(p,k)$ | $\mathbb{Z}_{>0}$ | 有限モノイド $M_d(\mathbb{Z}/p^k)$ 上で決定可能 |
| Newton 傾き | $\mu_{\min}(p)$ | $\mathbb{Z}_{\ge0}$ | 整数点の下方凸包（有限組合せ） |
| 岩澤不変量 | $\mu_p$ | $\mathbb{Z}_{\ge0}$（離散） | 塔の有限段で有限計算、ただし極限値の一般判定は本稿の主張外 |
| 全域木数 | $\tau(L)$ | $\mathbb{Z}_{>0}$ | Kirchhoff 行列式（厳密整数） |
| 自由エネルギー密度 / Mahler 測度 | $-\beta f=\log m(P)$ | $\mathbb{R}$（非可算） | 決定不能 |

**$\mathbb{R}$ 脱出の隔離**: $\mathbb{R}$ を要するのは **$L\to\infty$（および $N\to\infty$）の極限で $\frac1{L^2}\log|a_L|\to\log m(P)$ を語る一点だけ**である。有限 $L$ の主張（命題 A・B・C・N・L・T）は $\mathbb{Z}$ と $\Lambda$ と $\overline{\mathbb{Q}}$ で閉じ、$\mathbb{R}$ を一切使わない。

**$\overline{\mathbb{Q}}(\ell_p)$ の非線形部（Schanuel 条件付き層）を本体に含まない**: 本稿が $\Lambda$ 上で行う操作は、$\ell_p$ の $\mathbb{Z}$ 係数線形結合の等号・順序比較のみである。$\ell_p\ell_q$ のような積（Schanuel 条件を要する非線形部）は現れない。$p$ 進側でも完備体 $\mathbb{Q}_p$（濃度 $2^{\aleph_0}$）は使わず、$\mathbb{Z}$・$\mathbb{Z}/p^k$・$\overline{\mathbb{F}_p}$・数体の整数環の素イデアル分解という可算・有限の手続きに留める（`docs/research/R-Lambda-duality/` §3.1）。

---

## 4. 決定可能性の非対称（本稿の主眼）

| | $\mathbb{R}$ 側（アルキメデス） | $\Lambda$ 側（$p$ 進） |
|---|---|---|
| 対象 | Mahler 測度 ＝ エントロピー ＝ 自由エネルギー $\in\mathbb{R}$（連続・非可算） | 岩澤 $\mu_p$ ＝ $p$ 進エントロピー $\in\mathbb{Z}_{\ge0}$（離散・可算）、有限 $L$ では $v_p(a_L)\in\mathbb{Z}$ |
| 最小正値問題 | **Lehmer 問題（未解決、連続ギャップ）** | 立たない（整数値ゆえ最小正値 $=1$ が自明） |
| 一般の値 | 計算不能実数もありうる | 円分 $\mathbb{Z}_p$ 拡大では Ferrero–Washington で $\mu_p=0$。有限 $L$ の $v_p$ は無条件に決定可能 |
| 非可算性 | 除去不能（$\log_\mathbb{R}$ と極限の収束に本質的） | 除去可能（$\mathbb{Q}_p$ は説明上の足場にすぎない） |

**主張**: 双対の二側で難易度が対称でない。**難しい未解決の連続問題は $\mathbb{R}$ 側にのみ現れ、$\Lambda$ 側は離散・決定可能である。** これは既知の 2 つの理論（Lehmer/Mahler と 岩澤/Ferrero–Washington）が双対のどちらの素点に乗るかの**地図**であって、新しい定理ではない。

---

## 5. 構成案

1. **序**: 決定可能性の梯子（$\mathbb{N}\subset\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}\subset\mathbb{R}$）と四軸（帰属／計算可能性／複雑性／可解性）。可積分＝スペクトル方程式が代数的。
2. **セットアップ**: 整数転送行列 $T(z)$ とスペクトル曲線 $P(z,w)\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$、周期点数 $a_L$、Massieu $\Phi_L\in\Lambda$。抽象度の層（層0＝整数行列 1 個／層2＝変数 $z$ の族）を分ける。
3. **$\mathbb{R}$ 側（既知）**: LSW、Ising の Mahler 測度・$L$ 函数（arXiv:2407.19531）。ここが $\mathbb{R}$ 脱出の唯一点であることの明示。
4. **$\Lambda$ 側（既知理論への接地＋有限・決定可能な顔）**: Deninger の $p$ 進エントロピー、Besser–Deninger の $p$ 進 Mahler 測度、岩澤 $\mu_p$。そのうえで命題 A・B・C・N・L を、$\mathbb{Q}_p$ を使わない有限手続きとして提示。
5. **決定可能性非対称**: §4 の表。Lehmer 問題と Ferrero–Washington の配置。
6. **具体例**: $P=5-(z+z^{-1})-(w+w^{-1})$（両素点の最小実証）、離散ラプラシアン $P=4-(z+z^{-1})-(w+w^{-1})$（全域木・ダイマー・GFF、$\mathbb{R}$ 側が $4G/\pi$ に一致＝枠組みの検査）、六頂点 $(a,b,c)=(1,1,2)$、$P=z-c$（LTE の完全形）。
7. **偽の枝の刈り取り**: Wall 型等式（$\pi(p,k)=p^{k-1}\pi(p,1)$）は魅力的だが**反例により棄却**。0 件観察を根拠にしないこと、標本拡大で仮説が壊れた経緯を記述（方法論として書く）。
8. **スコープと限界**: 可解性（極限の閉形式）については何も主張しない。命題 D の ($p$) 側の一般性は未確定。

---

## 6. 検証計算の対応（実行ログのあるものだけを挙げる）

| 本稿の主張 | 検証ディレクトリ | 実行ログ | `README.md` の有無 |
|---|---|---|---|
| 同一 $P$ の両素点（最小実証、$P=5-(z+1/z)-(w+1/w)$） | `sagemath/check/cycle5_T1_mahler/` | `spectral_curve_both_places.out` | あり |
| 岩澤塔 $L=p^n$ での $v_p(a_{p^n})$（$\mu_p=0$ の例） | `sagemath/check/cycle6_T1_padic_mahler/` | `iwasawa_tower.out` | あり |
| 命題 L（LTE、$p$ 奇・$p=2$ とも全例一致） | `sagemath/check/cycle7_T1_lte/` | `lte_structure.out`, `lte_p2_complete.out` | あり |
| 離散ラプラシアン曲線の両素点（$\mathbb{R}$ 側 $\to 4G/\pi$） | `sagemath/check/cycle9_T1_spanning_tree/` | `spanning_tree_both_places.out` | あり |
| 命題 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）の証明の各段の確認＋偶 $L$ の反例 | `sagemath/check/cycle13_T1_tau_v2/` | `tau_v2_verify.out` | あり |
| 旧観察 T の初期検証＋グラフ岩澤理論への接地 | `sagemath/check/cycle10_T1_vp_law/` | `tau_vp_law.out`, `verify_more.out` | あり（＋`iwasawa_graph_README.md`） |
| 決定可能性非対称（Lehmer の $p$ 進版が存在しないことの整理） | `sagemath/check/cycle10_T3_lehmer/` | `lehmer.out` | あり（＋`padic_analog_README.md`） |
| 命題 A の全例検証（周期上界） | `sagemath/check/cycle3_T1_period_bound/` | `period_bound.out` | あり |
| 命題 B・C（$\pi(p,1)$ 精密公式、Wall 等式の反例） | `sagemath/check/cycle3_T3_period/` | `pi_p1_refined.out`, `pi_p1_closed_form.out`, `pi_p1_strict_demo.out`, `wall_large_scale.out`, `wall_nondegenerate.out`, `wall_search.out`, `wall_type_period.out` | あり（6 スクリプトを統合した `README.md`。＋スクリプト別 `*_README.md`） |
| 六頂点 $\Phi_N\in\Lambda$、$v_2(Z_N)=N+2$ 等 | `sagemath/check/D_phi_lambda/`, `sagemath/check/D-U2_padic_law/` | `sixvertex_phi_lambda.out`, `vp_law.out`, `eigenvalue_link.out` | あり |

**形式検証の水準について**: 本 plan は **Lean 成果物を含めない**（`lean/` は本プロジェクトに存在せず、導入も本企画の範囲外とする）。機械検証可能性は選別基準 (iii) の「SageMath で厳密計算でき、**原理的に** `decide`／witness に乗る」水準でのみ主張する。

---

## 7. 既知性リスク（`resolved_risk` / `novelty_risk`）

### `resolved_risk`（既に解決済みであるリスク）

**高い。調査結果として、本稿が扱う数学的内容は両側とも既に解決済みである。**

- $\mathbb{R}$ 側: Lind–Schmidt–Ward（エントロピー＝Mahler 測度）、Ising については arXiv:2407.19531 / Phys. Rev. E 110, 054134 (2024) で $L$ 函数まで精密化済み。
- $\Lambda$ 側: Besser–Deninger（$p$ 進 Mahler 測度）、Deninger（$p$ 進エントロピー）、arXiv:1702.03819（$\mathbb{Z}$-covers of links の balance formula）で確立。$\mu_p=0$ は Ferrero–Washington (1979)。
- 全域木の $\ell$ 進付値: arXiv:2006.14012 系のグラフ岩澤理論で研究済み。**命題 T が既に文献にある可能性は高く、未確認**（arXiv:1711.00175 / 1312.4389 は abstract のみ確認、本文未取得。`cycle13_T1_observation_T_settlement.md` §5）。したがって命題 T の新規性は主張しない。
- 命題 A・C: 線形漸化列の $p$ 進付値の最終周期性・Pisano 型上界は古典。命題 L: LTE は初等整数論の標準補題。

⇒ **本稿は「未解決問題の解決」を主張しない。** 主張するのは切り分け表の寄与 (a)–(d)、すなわち**再框・可算化・決定可能性の明示**である。

### `novelty_risk`（既知定理から自明に出るリスク）

**高い。**

- 命題 A・B・C・N・L はいずれも既知の初等整数論から導かれる。新しいのは適用先（可積分転送行列の Massieu $\Phi$）と、$\mathbb{Q}_p$ 不使用の可算化の明示だけである。
- 決定可能性非対称（§4）も、既知の 2 理論の配置を述べたものであり、それ自体が定理ではない。
- **残るリスク**: 「$\Lambda$ 側は $\mathbb{Q}_p$ を必要としない」という精密化（寄与 b）が、逆数学・構成的数学の文献に既出である可能性は**未調査**。ここは昇格前に調べる必要がある。

### 先行研究アンカーと、動かした軸（選別基準 (iv)）

- アンカー: **Deninger の $p$ 進エントロピー ＝ Besser–Deninger の $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$**（$\Lambda$ 側）、および **LSW のエントロピー＝Mahler 測度**（$\mathbb{R}$ 側）。
- 動かした軸: **1 本**。模型・境界・rank・可解性のいずれも動かしていない。動かしたのは**メタ軸＝「同じ対象を、どの集合の上でどの手続きで語るか」（可算化・決定可能性・形式検証可能性）**である。
- **注意**: このメタ軸は seed の (iv) が列挙する軸（境界・rank・模型・複雑性・可解性）に含まれていない。したがって (iv) の「1 本」判定は文言どおりには適用できず、**メタ軸を軸として認めるかどうかが未決**である。昇格前に seed 側の軸リストを更新するか、本稿の位置づけを (iv) の枠外として明記するかを決める必要がある。

### 対応する候補の `paper_potential`

- `outputs/candidates/D-U2_vp_law_theorem_candidate.md`: **`low`**（値域外の `low-medium` が使われていたため、G4 の指示に従い `docs/schemas.md` の値域 high/medium/low 内へ是正した。切り上げでなく切り下げを採り、新規性を誇張しない）。
- `outputs/candidates/D_massieu_phi_candidates.md` の D-U2 関連項目: `medium`。
- **本 plan はこの `low` 評価を覆さない。** cycle 3–11 で得たのは部分命題の厳密化と両側の既知理論への接地であり、新規性の限界（既知数学の再框である）は変わらない。基礎論・形式検証寄りのノートとしての価値を主張するに留める。

---

## 8. 未確定・昇格前に必要な作業

1. **命題 D の ($p$) 側の一般性の確定**: 一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$・$\mathbb{Z}_p^2$ 塔での $v_p(a_{p^n})$ の増大則を述べた文献命題を特定する（cycle 13 step 1 の調査では見つからなかった）。$d\ge2$ では単一の線形成長率にならない（DuBose–Vallières Thm A）ので、$P(\ell^n,n)$ 型の形を前提に探すこと。**($\infty$) 側の一般性は cycle 13 step 1 で確定済み**（LSW Thm 7.1 / LSV Thm 1.2, 1.3。ただし $\mathsf P_\Gamma$ と $a_L$ の $c_\Gamma$ 差を明示すること）。
2. **観察 T の決着**: （消化済み。cycle 13 step 3 で**証明した**。命題 T として §2 の確定部分命題へ移した。`outputs/reports/cycle13_T1_observation_T_settlement.md`。既出かどうかは本文未確認なので新規性は主張しない。）
3. **非自明な $\mu_p>0$ の実例**: （消化済み。cycle 12 step 3 で判定式 $\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$ とともに $\mu_2=2,\mu_3=1,\mu_{23}=1$ 等の例を構成。`sagemath/check/cycle12_T3_nonzero_mu_p/`。判定式は cycle 13 step 2 で**証明した**（`outputs/reports/cycle13_T3_mu_content_criterion_proof.md`
定理 1・2・3。$(★)$ と岩澤型漸近そのものも証明。新規性は主張しない＝McGown–Vallières III Thm 6.1 の言い換え）。
ただし射程は $d=1$ の $\ell$-塔に限られ、本稿の $L\times L$ トーラス（$\mathbb{Z}_\ell^2$-塔）には**そのままでは適用できない**。)
4. **寄与 (b) の既知性調査**: 「$\mathbb{Q}_p$ 不使用の可算化」が逆数学・構成的数学の文献に既出でないかを調べる。
5. **選別基準 (iv) のメタ軸の扱い**: （消化済み。cycle 12 で `inputs/seeds/lambda-statement-program.md` の (iv) に対象軸5本＋メタ軸3本を明文化。本稿はメタ軸1本のみを動かし、対象軸は1本も動かしていない。）

（消化済み）**`README.md` の欠落補完**: `sagemath/check/cycle6_T1_padic_mahler/`, `cycle3_T1_period_bound/`, `cycle3_T3_period/` の 3 ディレクトリに `README.md` を追加し、G3 の運用規約を満たした（G3 は `達成` へ）。

---

## 昇格判断

判断基準は `outputs/paper-plans/README.md` の G1–G6 ＋最終ゲート。判定語は `達成` / `未達` / `評価不能` / `非該当`。

| ゲート | 判定 | 根拠 |
|---|---|---|
| G1 中核命題が厳密に書き下されている | **未達** | cycle 13 step 1 で **($\infty$) 側の一般性は文献本文で確定**（LSW Thm 7.1 / LSV Thm 1.2・1.3）。しかし **($p$) 側は旧稿の同一視が誤りと判明**（$\hbar_p,m_p$ は $\log_p$ 定義ゆえ付値を測らない）、正しい量での一般性（2 変数・$\mathbb{Z}_p^2$ 塔）は文献に特定できていない（§2, §8-1、`outputs/reports/cycle13_T1_padic_entropy_generality.md`）。片側だけでは命題 D を書けない。部分命題 A・B・C・N・L・T は厳密（cycle 13 step 3 で命題 T の証明が付き、未証明の観察は無くなった）だが、テーゼ（双対）を単独で担わない。plan が挙げた必要計算は削除していない |
| G2 帰属と $\mathbb{R}$ 脱出の明示 | **評価不能** | §3 に本企画の各量の帰属台帳、$\mathbb{R}$ 脱出の一点（$L\to\infty$ での $\frac1{L^2}\log|a_L|\to\log m(P)$）、$\overline{\mathbb{Q}}(\ell_p)$ 非線形部を含まないことをいずれも記載済み。ただし G1 未達（中核命題 D の一般性が未確定）のため、台帳が中核命題の扱う量を**網羅しているか**を確認できない。README の G1 前提ルールにより `達成` にはしない |
| G3 検証計算が実行済みで再現可能 | **達成** | SageMath 側: §6 の 9 ディレクトリはすべて実行ログ（`.out`）をもち、**対象・手順・結論・限界を書いた `README.md` も 9 ディレクトリすべてに存在する**。欠落していた `sagemath/check/cycle6_T1_padic_mahler/`・`cycle3_T1_period_bound/` に `README.md` を新規作成し、`cycle3_T3_period/` にはスクリプト別 `*_README.md` を統合する `README.md` を追加した（いずれも実行ログに現れる値のみを根拠とし、数値一致を証明と呼ばず、0 件観察を仮説の支持根拠にしない旨を「限界」節に明記）。本プロジェクトの運用規約（`README.md` ＋ `.out`）を満たす。Lean 側: 本 plan は Lean 成果物を宣言せず、plan 本体から Lean 実装の計画を外している（§6）ため Lean 条項は適用しない |
| G4 既知性リスクが調査済み | **評価不能** | `resolved_risk` / `novelty_risk` を根拠文献名つきで記載（§7）、先行研究アンカーを Deninger／Besser–Deninger／岩澤 $\mu_p$、LSW と特定、動かした軸を 1 本（メタ軸）と明示、候補の `paper_potential` を `low` へ是正して引用済み（記載欠落なし）。ただし G1 未達のため、その調査範囲が中核命題に対して十分かを確認できない。加えて寄与 (b) の既知性が未調査（§8-4）、(iv) のメタ軸の扱いが未決（§7）で、いずれも `達成` を阻む |
| G5 トラックに応じた寄与の提示 | **達成** | トラックを **T1 Reframe** と明記。(1) 厳密化の対象となった既知結果を文献名で特定: Lind–Schmidt–Ward、arXiv:2407.19531 / Phys. Rev. E 110, 054134 (2024)、Besser–Deninger "p-adic Mahler measures"、Deninger "p-adic entropy and a p-adic Fuglede–Kadison determinant"、arXiv:1702.03819、Ferrero–Washington (1979)、arXiv:2006.14012、Lehmer (1933)、LTE・Pisano・Skolem–Mahler–Lech（§1 の表）。(2) 厳密化によって新たに機械検証可能になった命題の列挙: 命題 A（$\min(v_p(Z_N),k)$ の最終周期性、有限モノイド上で決定可能）、命題 B（$\pi(p,1)$ の lcm 公式、$\overline{\mathbb{F}_p}$ 上の有限計算）、命題 C（$\pi(p,k)\mid p^{k-1}\pi(p,1)$、および Wall 型等号の反例）、命題 N（$\mu_{\min}(p)$＝整数点の下方凸包）、命題 L（LTE 分岐、witness $=(\operatorname{ord}_p(c),v_p(c^d-1))$）（§2）。「可積分の新定理」とは呼ばず、再框であることを §1 冒頭・§1 末尾・§4 末尾で明示している |
| G6 統計的・論理的健全性チェック | **評価不能** | 4 項目すべてに該当/非該当を記載（下表）。ただし G1 未達のため `達成` にはしない |
| 最終ゲート（ユーザー承認） | 未取得 | 本 plan を論文として書くかのユーザー判断は未取得 |

### G6 の 4 項目

| 項目 | 該当/非該当 | 内容 |
|---|---|---|
| 1. 0 件を仮説の支持根拠にしない | **該当** | 対処: 検証例の $\mu_p=0$（`cycle6_T1_padic_mahler/iwasawa_tower.out` の $v_2=[0,0,0]$, $v_3=[0,0]$）を「$\Lambda$ 側が自明」という一般的主張の根拠にしていない。§2・§8-3 で「現在の例はすべて $\mu_p=0$ で $\Lambda$ 側の内容が薄い」と限界として明記し、非自明 $\mu_p$ の実例構成を昇格前作業に挙げた。また Wall 等式については、cycle 5 の 0/43（有意でない）を根拠にせず、cycle 6 で標本を 572 件へ桁で拡大して 4.5% の反例を得た経緯（§5-7, §2 命題 C）を記述する |
| 2. 構造判定を代理指標で行わない | **該当** | 対処: 本 plan の判定はすべて定義に直結する手段による。$v_p$ は $\mathbb{Z}$ 上の整除、$\pi(p,k)$ は $M_d(\mathbb{Z}/p^k)$ 上の周期、$\mu_{\min}$ は Newton 多角形（整数点の下方凸包）、$\mu_p$ は塔上の線形成長率。「次数」「桁」等の代理指標は使わない。なお本 plan はカイラル Potts の Onsager 構造（Dolan–Grady で判定すべき対象）を扱わない |
| 3. スケールの偶然一致を接続と呼ばない | **該当** | 対処: cycle 10 で $4G/\pi$ と Lehmer 数のスケール一致を接続と誤認しかけた経緯を踏まえ、本 plan では $4G/\pi$ を**既知値との一致による枠組みの検査**としてのみ使い（§5-6, §1 の表）、Lehmer 問題とは接続しない。Lehmer は §4 で「$\mathbb{R}$ 側にのみ現れる未解決の連続ギャップ」という**位置づけの記述**に限定する |
| 4. 数値一致は証拠であって証明ではない | **該当** | 対処: §2 を「厳密に確定している部分命題」と「検証済みだが未証明の観察」に分節して運用している。旧観察 T は未証明の間このカテゴリに置き、cycle 13 step 3 で証明が付いた時点で命題 T として前者へ移した（数値検証の段階と証明済みの段階を混同しない運用）。$\frac1{L^2}\log|a_L|$ の数値収束（cycle5 で 1.354→1.508）も、収束の証明は LSW（既知定理）に帰し、数値そのものを証明扱いしない |

### 状態

**据え置き**（G1 が `未達`、G2・G4・G6 が `評価不能`、最終ゲート未取得）。
G3 は 3 ディレクトリへの `README.md` 追加により `達成` となった。次に効くのは §8 の 1（命題 D の ($p$) 側の一般性確定）。観察 T は cycle 13 step 3 で決着した。
