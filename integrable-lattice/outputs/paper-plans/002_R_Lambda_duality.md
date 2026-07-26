# Paper plan 002: ℝ/Λ 双対 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性

トラック: **T1 Reframe**（`docs/themes.md`）。
状態: **昇格済** → 論文本体は `outputs/papers/001_R_Lambda_duality/`。判定は末尾「昇格判断」。

## 昇格の記録

- **承認日**: 2026-07-26
- **承認者**: 依頼者（管理セッション経由）
- **承認範囲**: 本企画を論文として執筆すること。`outputs/papers/001_R_Lambda_duality/` へ昇格。
- **承認時の判定**: `outputs/paper-plans/README.md` の G1–G6 がすべて `達成`、最終ゲート（ユーザー承認）を本承認で充足。
- **承認に伴う方針変更**: 本企画は「Lean 等の形式検証は含めない」としていたが、**依頼者の指示により変更**。
  Lean による形式検証を論文の構成要素に含める（`integrable-lattice/lean/`）。
  §6 の「Lean 成果物を含めない」宣言は**撤回**し、G3 の Lean 条項が適用されるようになった。
- **本 plan はこのまま `paper-plans/` に残す**（企画の履歴を消さない。`README.md` 昇格手順 4）。
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
| $v_p(a_{p^n})>0\iff p\mid P(1,1)$（$d$ 変数、非自明性の完全な判定） | 本プロジェクト（cycle 14 で証明。初等的で folklore の可能性が高く**新規性は主張しない**） | `outputs/reports/cycle14_T1_vp_growth_two_variable.md` 命題 V・補題 V0 |
| グラフの $\mathbb{Z}_\ell^d$ 塔での $\mathrm{ord}_\ell(\kappa_n)$ の**明示的な主要係数**（誤差項なし） | **既知** | Kataoka, *An Iwasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs*, arXiv:2606.03579（abstract 確認。主要係数 $\lambda,\mu$ を明示し先行研究の誤差項を除去したと述べている。**本文未取得**）。$\ell^{2n}$ 係数は Cuoco–Monsky の $m_0$ 不変量 |
| 非退化なグラフ $\mathbb{Z}_\ell^2$ 塔での完全な閉形式 $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$ | 本プロジェクト（cycle 14 で証明。**新規性は主張しない**＝上記 Kataoka が同種の公式を与えている） | `outputs/reports/cycle14_T3_two_variable_criterion.md` 定理 5（第 1 経路）。独立な第 2 経路 `cycle14_T3_Zl2_tower_criterion.md` |
| 一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$（グラフのラプラシアンでないもの）の $v_p(a_{p^n})$ の**増大の完全な形** | **未特定・未証明** | — |
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

### 双対命題 D（cycle 15 で確定。仮定・結論・一般性の範囲まで書き下せる）

$d\ge1$、$P\in\mathbb{Z}[z_1^{\pm1},\dots,z_d^{\pm1}]\setminus\{0\}$ とする。$L\ge1$ に対し**簡約周期点数**を
$$a^{\mathrm{red}}_L:=\prod_{\substack{z_i^{L}=1\\ P(z)\neq0}}P(z_1,\dots,z_d)\in\mathbb{Z}$$
（$P$ の零点となる因子を除いた積。$P$ がトーラス上に零点をもたなければ通常の $a_L$ に一致）と定める。
$\mathsf U(P)=\{z\in\mathbb{S}^d:P(z)=0\}$（複素単位トーラス上の零点集合）と置く。

**(∞ 素点)** $\dim\mathsf U(P)\le d-2$（$P$ が **atoral**）ならば
$$\frac{1}{L^{d}}\log\bigl|a^{\mathrm{red}}_L\bigr|\ \longrightarrow\ \log m(P)\qquad(L\to\infty).$$
一般性の 3 段は文献本文で確定: エントロピー $=\log m(P)$ は**無条件**（Lind–Schmidt–Ward, Invent. math. **101** (1990), Thm 3.1）／
周期点の増大率 $=$ エントロピーは一般には**不成立**で expansive（$\mathsf U(P)=\varnothing$）で成立（同 Thm 7.1）／
$\mathsf U(P)$ 有限で成立（Lind–Schmidt–Verbitskiy, arXiv:1108.4989, Thm 1.2）／$\dim\mathsf U(P)\le d-2$ で成立（同 Thm 1.3）。

**(p 素点, 有限 $L$)** 任意の素数 $p$、任意の $L$ について $v_p(a^{\mathrm{red}}_L)\in\mathbb{Z}_{\ge0}$ は
**$\mathbb{Z}$ 上の有限手続きで計算できる**（$d$ 重の終結式で厳密整数を得てから素因数分解）。$\mathbb{R}$ も $\mathbb{Q}_p$ も使わない。
さらに $L=p^n$ の塔では**非自明性が完全に判定できる**（命題 V）: $v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$。

**(p 素点, 塔の漸近)** $\Gamma\simeq\mathbb{Z}_p^d$、$f:=P(\sigma_1,\dots,\sigma_d)\in\mathbb{Z}_p[\Gamma]$
（$\sigma_i$ は基底、Serre 同型 $\sigma_i\mapsto1+T_i$）とすると
$$v_p\bigl(a^{\mathrm{red}}_{p^n}\bigr)=\sum_{\substack{\chi\in\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_p(\chi(f)),$$
したがって有理数 $\lambda_1,\mu_1,\dots,\lambda_{d-1},\mu_{d-1},\nu$ が存在して $n\gg0$ で
$$v_p\bigl(a^{\mathrm{red}}_{p^n}\bigr)=\bigl(\lambda n+\mu p^n\bigr)p^{(d-1)n}
+\sum_{i=1}^{d-1}\bigl(\lambda_i n+\mu_i p^n\bigr)p^{(d-1-i)n}+\nu,$$
$$\lambda=l_0(f),\qquad \mu=m_0(f)=v_p\bigl(\mathrm{content}\,P\bigr)\in\mathbb{Z}_{\ge0}.$$
根拠は Monsky Thm 5.6 ＋ Cuoco–Monsky Thm 1.7（Kataoka arXiv:2606.03579 の Theorem 2.1 / Theorem 2.3 /
Definition 2.2 として本文で確認）。$\mu=v_p(\mathrm{content}P)$ は補題 D（$z_i\mapsto1+T_i$ が $\mathbb{Z}$ 上の環同型ゆえ content 不変）による。
グラフの場合 $\mathrm{ord}_p(\kappa_{X_n})$ は上式から $-dn+\mathrm{ord}_p(\kappa(X))-\mathrm{ord}_p(\#V_X)$ ずれる
（`cycle15_T1_kataoka_and_general_P.md` $(3.3)$）。

**明示された限界（命題の一部として述べる）**:
- $\lambda=l_0(f)$ は不変量として確定するが、**計算可能性（$\mathbb{Z}$ 上の有限手続き）は未確立**。
  $\bar f$ の $\mathbb{P}^1(\mathbb{F}_p)$ 有理線形因子の重複度の和は**上限しか与えない**（反例 $P=z+w^2-2w$, $p=3$）。
  素イデアル $(\gamma-1)$ が $\mathbb{P}^1(\mathbb{Z}_p)$ で添字づけられるためである。
- $\lambda_i,\mu_i,\nu$（$i\ge1$）は**有理数**で整数とは限らず、文献も明示公式を与えていない。
  非退化な $d=2$ グラフ塔の $\mu_1$ は命題 W が与える。
- $\chi(f)=0$ となる $\chi$ の個数が $n$ とともに増える $P$ については、$a^{\mathrm{red}}$ と $a$ の関係の整理が未了。

**ℝ 脱出の隔離**: $\mathbb{R}$ を要するのは (∞ 素点) の $L\to\infty$ **ただ一点**。(p 素点) の両主張は
$\mathbb{Z}$・$\mathbb{Q}$ の中で閉じる。

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

- **命題 V（$\Lambda$ 側が非自明になる条件, 証明済み）.** $P\in\mathbb{Z}[z_1^{\pm},\dots,z_d^{\pm}]$、$p$ 素数、$L=p^n$ とすると
  $$a_{p^n}\equiv P(1,\dots,1)^{\,p^{dn}}\pmod p,\qquad\text{ゆえに}\quad v_p(a_{p^n})>0\iff p\mid P(1,\dots,1).$$
  （証明: `outputs/reports/cycle14_T1_vp_growth_two_variable.md` §3。$\bmod p$ で $z^{p^n}-1=(z-1)^{p^n}$ となるので
  終結式表示 $a_L=\mathrm{Res}(z^L-1,\mathrm{Res}(w^L-1,P))$ が潰れる。$\mathbb{Q}_p$ も代数的整数論も使わない初等証明。
  検証 `sagemath/check/cycle14_T1_vp_two_var/`。**新規性は主張しない**。）
  これにより「いつ $\Lambda$ 側に内容があるか」が有限手続きで決定できる。

- **命題 W（非退化グラフ塔の閉形式, 証明済み）.** $X$ を有限連結多重グラフ、$\alpha:E\to\mathbb{Z}^2$ を voltage、
  $\ell$ 素数とし、$f=\det L(1+T,1+S)$ の $\bmod\,\ell$ 還元の最低次斉次部分 $H$（次数 $k$）が
  $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない（＝非退化。係数の有限計算で判定可能）とする。このとき $n\gg0$ で
  $$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu,\qquad \mu=v_\ell(\mathrm{content}_{z,w}\det L).$$
  （証明: `outputs/reports/cycle14_T3_two_variable_criterion.md` 定理 5。独立な第 2 経路
  `cycle14_T3_Zl2_tower_criterion.md` が同じ境界に到達している。$\mu$ の上界方向のみ外部定理に依拠。
  **新規性は主張しない**＝Kataoka arXiv:2606.03579 が同種の明示公式を与えている。）
  本稿の $L\times L$ トーラス（$P(1,1)=0$ のレジーム）は $\ell=3,7,\dots$（$-1$ が非平方な $\ell$）で射程内、
  $\ell=2$ は退化ケースで射程外。

- **命題 V（$\Lambda$ 側が非自明になる条件, 証明済み）.** $P\in\mathbb{Z}[z_1^{\pm},\dots,z_d^{\pm}]$、$p$ 素数、$L=p^n$ とすると
  $$a_{p^n}\equiv P(1,\dots,1)^{\,p^{dn}}\pmod p,\qquad\text{ゆえに}\quad v_p(a_{p^n})>0\iff p\mid P(1,\dots,1).$$
  （証明: `outputs/reports/cycle14_T1_vp_growth_two_variable.md` §3。$\bmod p$ で $z^{p^n}-1=(z-1)^{p^n}$ となり
  終結式表示が潰れる。$\mathbb{Q}_p$ も代数的整数論も使わない初等証明。検証 `sagemath/check/cycle14_T1_vp_two_var/`。
  **新規性は主張しない**。）

- **命題 W（非退化グラフ塔の閉形式, 証明済み）.** $X$ を有限連結多重グラフ、$\alpha:E\to\mathbb{Z}^2$ を voltage、
  $\ell$ 素数とし、$f=\det L(1+T,1+S)$ の $\bmod\,\ell$ 還元の最低次斉次部分 $H$（次数 $k$）が
  $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない（非退化。係数の有限計算で判定可能）とする。$n\gg0$ で
  $$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu,\qquad \mu=v_\ell(\mathrm{content}_{z,w}\det L).$$
  （証明: `outputs/reports/cycle14_T3_two_variable_criterion.md` 定理 5。独立な第 2 経路
  `cycle14_T3_Zl2_tower_criterion.md` が同じ境界に到達。$\mu$ の上界方向は cycle 15 で Cuoco–Monsky Thm 1.7 に帰着。
  **新規性は主張しない**＝Kataoka arXiv:2606.03579 が同種の明示公式を与えている。）
  $L\times L$ トーラスは $\ell=3,7,\dots$（$-1$ が非平方な $\ell$）で射程内、$\ell=2$ は退化ケースで射程外。

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

**形式検証の水準について（2026-07-26 に方針変更）**: 旧稿は「Lean 成果物を含めない」と宣言していたが、
**依頼者の指示により撤回した**。本論文は Lean 4 + mathlib4 による形式検証を構成要素に含める（`integrable-lattice/lean/`）。
形式化した命題と、形式化できなかった命題およびその理由は `integrable-lattice/lean/README.md` の
「形式化の現状」表に記録する。「原理的に `decide`／witness に乗る」という水準の主張は、
実際に形式化できた命題については**実証に置き換わる**。

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

### 寄与 (b)（$\mathbb{Q}_p$ 不使用の可算化）の既知性調査（cycle 15 で実施）

- **調査手段**: WebSearch を 2 件（reverse mathematics + p-adic + RCA_0 + countable coding／
  reverse mathematics or constructive + p-adic valuation + Iwasawa invariants + computability）。
  **abstract レベルのみ。本文は取得していない。**
- **結果**: 「$\mathbb{Q}_p$ を使わずに可算・有限手続きへ還元する」趣旨の先行研究は**見つけられなかった**。
  隣接する既知結果として **Ax–Kochen / Ershov**（$\mathbb{Q}_p$ は切断つき付値体の言語で**決定可能**）を確認した。
  したがって「$\mathbb{Q}_p$ を避ける」動機は $\mathbb{Q}_p$ の一階理論の決定不能性ではなく、
  本プログラムの有限手続き・witness の立場に由来する。この区別は論文で明示する必要がある。
- **判断**: **見つからなかったことを新規性の根拠にしない**。寄与 (b) は「既知数学の可算再框」として位置づけ、
  **新規性は主張しない**。逆数学・構成的数学の本文調査は未実施なので、投稿前に専門家確認を要する事項として残す。

### 先行研究アンカーと、動かした軸（選別基準 (iv)）

- アンカー（cycle 13・15 で訂正済み）: **($\infty$ 側)** Lind–Schmidt–Ward のエントロピー＝Mahler 測度（Thm 3.1, 7.1）と
  Lind–Schmidt–Verbitskiy の atoral 版（Thm 1.2, 1.3）。**($p$ 側)** Monsky Thm 5.6 ＋ Cuoco–Monsky Thm 1.7
  （$\lambda=l_0$, $\mu=m_0$）、およびグラフへの適用としての Kataoka arXiv:2606.03579 Thm 1.1。
  **注意**: 旧稿がアンカーに挙げていた「Deninger の $p$ 進エントロピー ＝ Besser–Deninger の $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$」は
  cycle 13 で**誤りと判明して撤回した**（$\hbar_p,m_p$ は岩澤対数で定義され付値を測らない）。アンカーではない。
- 動かした軸: **1 本**。模型・境界・rank・可解性のいずれも動かしていない。動かしたのは**メタ軸＝「同じ対象を、どの集合の上でどの手続きで語るか」（可算化・決定可能性・形式検証可能性）**である。
- **注意**: このメタ軸は seed の (iv) が列挙する軸（境界・rank・模型・複雑性・可解性）に含まれていない。したがって (iv) の「1 本」判定は文言どおりには適用できず、**メタ軸を軸として認めるかどうかが未決**である。昇格前に seed 側の軸リストを更新するか、本稿の位置づけを (iv) の枠外として明記するかを決める必要がある。

### 対応する候補の `paper_potential`

- `outputs/candidates/D-U2_vp_law_theorem_candidate.md`: **`low`**（値域外の `low-medium` が使われていたため、G4 の指示に従い `docs/schemas.md` の値域 high/medium/low 内へ是正した。切り上げでなく切り下げを採り、新規性を誇張しない）。
- `outputs/candidates/D_massieu_phi_candidates.md` の D-U2 関連項目: `medium`。
- **本 plan はこの `low` 評価を覆さない。** cycle 3–11 で得たのは部分命題の厳密化と両側の既知理論への接地であり、新規性の限界（既知数学の再框である）は変わらない。基礎論・形式検証寄りのノートとしての価値を主張するに留める。

---

## 8. 未確定・昇格前に必要な作業

1. **命題 D の ($p$) 側の一般性の確定**: （**cycle 15 で決着**。Monsky Thm 5.6 ＋ Cuoco–Monsky Thm 1.7 を
   Kataoka arXiv:2606.03579 の本文で確認し、一般の $P$ に適用できることを示した。
   `outputs/reports/cycle15_T1_kataoka_and_general_P.md`。命題 D を §2 に書き下した。）
   **残る個別の未解決点**（命題 D 内に限界として明示済み。命題の書き下しは妨げない）:
   (i) $\lambda=l_0(f)$ の計算可能性、(ii) $\lambda_i,\mu_i,\nu$（$i\ge1$）の明示公式、
   (iii) $\chi(f)=0$ となる $\chi$ が $n$ とともに増える $P$ の整理。
2. **観察 T の決着**: （消化済み。cycle 13 step 3 で**証明した**。命題 T として §2 の確定部分命題へ移した。`outputs/reports/cycle13_T1_observation_T_settlement.md`。既出かどうかは本文未確認なので新規性は主張しない。）
3. **非自明な $\mu_p>0$ の実例**: （消化済み。cycle 12 step 3 で判定式 $\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$ とともに $\mu_2=2,\mu_3=1,\mu_{23}=1$ 等の例を構成。`sagemath/check/cycle12_T3_nonzero_mu_p/`。判定式は cycle 13 step 2 で**証明した**（`outputs/reports/cycle13_T3_mu_content_criterion_proof.md`
定理 1・2・3。$(★)$ と岩澤型漸近そのものも証明。新規性は主張しない＝McGown–Vallières III Thm 6.1 の言い換え）。
ただし射程は $d=1$ の $\ell$-塔に限られ、本稿の $L\times L$ トーラス（$\mathbb{Z}_\ell^2$-塔）には**そのままでは適用できない**。)
4. **寄与 (b) の既知性調査**: （cycle 15 で実施。§7 に調査手段・結果・隣接既知結果 (Ax–Kochen/Ershov) を記録。abstract レベルのみで本文未取得。新規性は主張しない。投稿前に専門家確認を要する事項として残す。）
5. **選別基準 (iv) のメタ軸の扱い**: （消化済み。cycle 12 で `inputs/seeds/lambda-statement-program.md` の (iv) に対象軸5本＋メタ軸3本を明文化。本稿はメタ軸1本のみを動かし、対象軸は1本も動かしていない。）

（消化済み）**`README.md` の欠落補完**: `sagemath/check/cycle6_T1_padic_mahler/`, `cycle3_T1_period_bound/`, `cycle3_T3_period/` の 3 ディレクトリに `README.md` を追加し、G3 の運用規約を満たした（G3 は `達成` へ）。

---

## 昇格判断（cycle 15 で再判定 → 2026-07-26 に承認取得）

判断基準は `outputs/paper-plans/README.md` の G1–G6 ＋最終ゲート。判定語は `達成` / `未達` / `評価不能` / `非該当`。

| ゲート | 判定 | 根拠 |
|---|---|---|
| G1 中核命題が厳密に書き下されている | **達成** | §2 の**双対命題 D** が仮定（$P\neq0$、(∞) 側は atoral $\dim\mathsf U(P)\le d-2$）・結論・成立する一般性の範囲まで確定した命題文として存在する。(∞) 側は cycle 13 で LSW Thm 3.1/7.1・LSV Thm 1.2/1.3 の 3 段を本文確認。($p$) 側は cycle 15 で Monsky Thm 5.6 ＋ Cuoco–Monsky Thm 1.7 を Kataoka arXiv:2606.03579 の本文（Thm 2.1 / Thm 2.3 / Def 2.2）で確認し一般の $P$ へ適用できることを示した。残る 3 つの未解決点は**命題 D の中に限界として明示**してあり、命題の書き下しを妨げない。§8 の 1–6 はすべて消化または明示的に据え置きで、削除していない |
| G2 帰属と $\mathbb{R}$ 脱出の明示 | **達成** | §3 の台帳が命題 D に現れる全ての量を覆う（cycle 15 で $\mu=m_0$、$\lambda=l_0$、$\lambda_i,\mu_i,\nu\in\mathbb{Q}$、$a^{\mathrm{red}}_L$ を追加）。$\mathbb{R}$ 脱出は (∞) 側の $L\to\infty$ **一点**に隔離。$\overline{\mathbb{Q}}(\ell_p)$ 非線形部を含まないことも §3 に記載 |
| G3 検証計算が実行済みで再現可能 | **達成** | §6 の全ディレクトリが `README.md` ＋ `.out` を備える。**Lean 条項は 2026-07-26 の方針変更により適用される**ようになった（§6）。Lean 側の充足状況は `integrable-lattice/lean/README.md` の「形式化の現状」表と `scripts/check-no-sorry.sh` の出力で確認する |
| G4 既知性リスクが調査済み | **達成** | `resolved_risk`・`novelty_risk` を §7 に調査範囲・結果・**根拠文献名**つきで記載。本文確認した文献: LSW (1990)、LSV arXiv:1108.4989、Deninger arXiv:math/0608539、Ueki arXiv:1702.03819、McGown–Vallières arXiv:2107.07639、DuBose–Vallières Alg. Comb. 6 (2023)、Kataoka arXiv:2606.03579。寄与 (b) の既知性調査も cycle 15 で実施（§7）。動かした軸はメタ軸 **1 本**で対象軸は 0 本。対応候補の `paper_potential` は `low` で覆さない旨を明記。**すべての主張について新規性を主張していない** |
| G5 トラックに応じた寄与の提示 | **達成** | T1 Reframe と明記。(1) 厳密化の対象となった既知結果を文献名で特定（§1 の表、§7）。(2) 新たに機械検証可能になった命題を列挙: 命題 A・B・C・N・L・T・V・W（§2）。「可積分の新定理」と呼ばず再框であることを明示 |
| G6 統計的・論理的健全性チェック | **達成** | 4 項目すべてに該当/非該当と対処内容を記載（下表）。cycle 13–15 で実際に 3 種の誤り（誤った同一視、4 段フィットの数値的誤り、偽の同値）を検出・訂正しており運用が機能している |
| 最終ゲート（ユーザー承認） | **取得（2026-07-26）** | 冒頭「昇格の記録」参照。承認に伴い Lean 方針も変更された |

### 状態

**昇格済**（G1–G6 すべて `達成`、最終ゲートを 2026-07-26 に取得）。論文本体は `outputs/papers/001_R_Lambda_duality/`。

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
