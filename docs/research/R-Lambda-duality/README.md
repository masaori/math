# ℝ/Λ 双対（概要・現状まとめ）

別セッションでの質問・深掘り用のまとめ。出どころは `integrable-lattice` の cycle 2（方向 D-U2）で観察した現象。
**確立済み（SageMath で計算検証）** と **概念的（解釈・要検証）** を明確に分ける。

記号の集合帰属を常に併記する（CLAUDE.md 厳密性原則）。$\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ は対数順序群（`docs/discussion/対数順序群上の統計力学/`）。

---

## 抽象度の層（各節がどの層の主張かを明示）

議論の混線を防ぐため、以下の 4 層を区別する。各節の主張がどの層に属するかを常に意識する。

| 層 | 対象（所属集合を明示） | 何が言えるか | 使う道具 |
|---|---|---|---|
| **層0**（最抽象）| 単一の整数正方行列 $T\in M_d(\mathbb{Z})$（$d\in\mathbb{N}_{>0}$ 固定） | $Z_N=\operatorname{Tr}(T^N)\in\mathbb{Z}$ の $v_p$ 構造（**定理 P / D-U2**） | 線型代数・整数論のみ。$\mathbb{R}$ 不使用 |
| **層1** | その $T$ が「$L$ 列格子模型の行転送行列」として得られる（$d=$1行の状態数、$L$ 依存）| $Z_N$＝分配関数、$\Phi_N$＝Massieu エントロピーという**解釈** | 層0と同じ数学 |
| **層2** | 行列を1個に固定せず変数 $z$ を持つ族 $T(z)\in M_{d_0}(\mathbb{Z}[z^{\pm1}])$。スペクトル曲線 $P(z,w)=\det(wI-T(z))\in\mathbb{Z}[z^{\pm1},w]$ | Mahler 測度・自由エネルギー・adelic 統合 | **フーリエ変換**（＝並進対称性 $S$ の固有空間分解）・複素解析・積分（$\mathbb{R}/\mathbb{C}$ 脱出）|
| **層3**（最具体）| 六頂点・Ising 等、特定重みの実例 | 具体値計算（$\operatorname{charpoly}=(x-6)(x+2)(x-2)^2$ 等）| 層0–2の特殊化 |

**節と層の対応**: §1–§3（定理 P）は**層0**で完結（フーリエも物理も不要、整数行列1個で閉じる）。§4（Mahler 測度・Bloch 位相・フーリエ）は**層2**（変数 $z$ の族へ登る局面。フーリエはここだけの道具）。§5（六頂点・Ising 例）は**層3**。フーリエ変換は $\mathbb{R}/\Lambda$ 双対の核（定理 P）には不要で、双対を 2 変数 Mahler 測度に接続する層2でのみ現れる。

補足（フーリエ変換の層2定義）: 体 $\mathbb{K}$（$1$ の $L$ 乗根を含む）上の有限次元空間 $V$ に、並進 $S\in GL(V)$（$S^L=\operatorname{id}_V$）が作用するとき、$x^L-1=\prod_k(x-\zeta_L^k)$ が相異なる根をもつことから $V=\bigoplus_{k=0}^{L-1}V_k$（$V_k=\ker(S-\zeta_L^k)$、$\zeta_L=e^{2\pi i/L}$）と固有空間分解する。これがフーリエ変換。$S$ と可換な $T$ は各 $V_k$ を保ち、$T=\bigoplus_z T(z)$（$z=\zeta_L^k\in\mu_L$、有限 $L$ では代数的で $\mathbb{R}$ 不要）とブロック対角化される。これが $T(z)$ の由来。

---

## 0. 一言で

整数転送行列 $T$ の**同一の固有値集合 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$** が、$\mathbb{Q}$ の異なる「素点」で別々の物理量を支配する:

- **アルキメデス素点 $\infty$（絶対値 $|\cdot|_\infty$）** → 自由エネルギー（$\mathbb{R}$, 解析, $N\to\infty$）。
- **各 $p$ 進素点（$|\cdot|_p$）** → Massieu 自由エントロピー $\Phi_N\in\Lambda$ の素因数構造（可算, 決定可能, 有限 $N$）。

「絶対値」と「$p$ 進付値」という同一スペクトルの二つの見方が、$\mathbb{R}$ 側と $\Lambda$ 側に対応する。

---

## 1. セットアップ（確立済み）

- 可積分模型の転送行列 $T\in M_d(\mathbb{Z})$（整数 Boltzmann 重み）。
- $N$ 行 $L$ 列トーラスの分配関数 $Z_N=\mathrm{Tr}\,T^N\in\mathbb{Z}_{>0}$（$L$ 固定）。
- Massieu 自由エントロピー $\Phi_N=\log Z_N\in\Lambda$（素因数分解の指数ベクトル）。
- 固有値 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$（charpoly $\in\mathbb{Z}[x]$ の根）、$Z_N=\sum_i\lambda_i^N$。

検証コード: `integrable-lattice/sagemath/check/D-U2_padic_law/`, `.../potts_phi/`。

---

## 2. $\mathbb{R}$ 側（アルキメデス）— 確立済み（古典）

自由エネルギー密度
$$-\beta f=\lim_{N\to\infty}\frac1{NL}\log Z_N=\frac1L\log\lambda_{\max},$$
$\lambda_{\max}$ は**絶対値最大の固有値**（Perron）。住処は $\mathbb{R}$、解析・連続極限（$\Lambda$ からの脱出 (b) $N\to\infty$）。支配するのは $|\lambda|_\infty$。

---

## 3. $\Lambda$ 側（$p$ 進）— 確立済み（本セッション, 定理候補 D-U2）

各素数 $p$ について、$\Phi_N$ の $\ell_p$ 係数（$=v_p(Z_N)$）は
$$v_p(Z_N)=\mu_{\min}(p)\,N+r_p(N),$$
- $\mu_{\min}(p)=\min_i v_p(\lambda_i)\in\mathbb{Z}_{\ge0}$ = 固有値の**最小 $p$ 進付値** = charpoly の **$p$ 進 Newton 多角形**の一端の辺の傾き（符号は多角形の描き方の規約に依存。曖昧さのない定義は「付値の最小」）。
- $r_p(N)$ = 最終周期的な残差（ただし Skolem–Mahler–Lech 由来の疎な例外指数でスパイクしうる。特殊素数 $p\mid$（模型の対称性位数）で周期増大）。

住処は $\Lambda$（係数は $\mathbb{Z}$）、決定可能・有限 $N$・$\mathbb{R}$ 不使用。支配するのは $|\lambda|_p$（最小付値固有値）。

機構: $Z_N=p^{\mu_{\min}N}\sum_i u_i^N$（$u_i=\lambda_i/p^{\mu_{\min}}$、最小付値群は $p$ 進単位）。単位和は単位係数の線形漸化列で mod $p^k$ 周期的 ⇒ その $v_p=r_p$ が最終周期。

### 3.1 $\Lambda$ 側は $\mathbb{Q}_p$ を必要としない（可算・決定可能であることの精密化）

上の記述で $p$ 進完備体 $\mathbb{Q}_p$（およびその代数閉包 $\overline{\mathbb{Q}_p}$）は説明上の足場にすぎない。$\mathbb{Q}_p$ は濃度 $2^{\aleph_0}$ の**非可算**集合であり、その導入は $\mathbb{R}$ 脱出と同格の非可算化なので、$\Lambda$ 側の主張には**使わない**のが本プロジェクトの立場として正確。D-U2 で実際に触れる対象はすべて可算・有限・決定可能:

- **$v_p(Z_N)\in\mathbb{Z}_{\ge0}$**: $Z_N\in\mathbb{Z}_{>0}$ を $p$ で割り切れる回数。$\mathbb{Z}$ 上の有限手続き。これが $\Phi_N$ の $\ell_p$ 係数そのもの。
- **$\mu_{\min}(p)$**: $\operatorname{char}_T(x)=\sum_j c_j x^j$ の**整数係数の付値 $v_p(c_j)\in\mathbb{Z}$** から、点集合 $\{(j,v_p(c_j))\}$ の下方凸包（有限個の整数点の凸包）として計算。固有値 $\lambda_i$ を個別に構成する必要はなく、埋め込みの選択に依らない組合せ的手続き。
- **固有値の付値の可算な意味づけ**: 「$v_p$ を $\lambda_i\in\overline{\mathbb{Q}}$ へ拡張」も $\overline{\mathbb{Q}_p}$ を経ず、可算数体 $K=\mathbb{Q}(\lambda_i)$ の整数環 $\mathcal O_K$ における素イデアル $\mathfrak p\mid p$ の分解という有限・代数的手続きで済む（$\overline{\mathbb{Q}}$ 自身も可算）。
- **機構**: mod $p^k$ 線形漸化の最終周期性は、位数 $p^{kd}$ の**有限**集合 $(\mathbb{Z}/p^k\mathbb{Z})^d$ 上の鳩の巣論法。

含意: $\Lambda$ 側の非可算性（$\mathbb{Q}_p$）は本質的でなく**除去できる**。対して $\mathbb{R}$ 側（§2）の非可算性は $\log_\mathbb{R}$ と極限 $N\to\infty$ の収束に本質的で**除去できない**。この非対称性が「$\mathbb{R}/\Lambda$ 双対」で $\Lambda$ 側を「決定可能・可算」と呼べる根拠であり、双対の対比をむしろ強める。

---

## 4. 統一像（概念的・要検証）：adelic / 積公式 / Mahler 測度

**仮説的解釈**（まだ厳密命題化していない）:

- 同じ $\overline{\mathbb{Q}}$ の固有値が、$\mathbb{Q}$ の各素点 $v\in\{\infty\}\cup\{p\}$ で別の量を支配する。$\mathbb{R}$ 側（$\infty$）= 自由エネルギー、$\Lambda$ 側（$p$）= $\Phi$ の数論構造。これは**同一スペクトルの異なる完備化への射影**。
- **積公式** $\prod_v|x|_v=1$（$x\in\mathbb{Q}^\times$）が、両側を結ぶ可能性。$\log\lambda_{\max}$（$\infty$ の寄与）と $\{\mu_{\min}(p)\}$（$p$ の寄与）の間に大域的関係があるか？
- **Mahler 測度との関係**: $\log\lambda_{\max}$ は charpoly の支配根の対数で、Mahler 測度 $m(\mathrm{charpoly})=\sum_i\log\max(1,|\lambda_i|_\infty)$ と関連。
- **代数力学**: Lind–Schmidt–Ward の定理「$\mathbb{Z}^d$ 作用の位相的エントロピー = 多項式の Mahler 測度」があり、その **$p$ 進類似（$p$ 進エントロピー / adelic Mahler 測度）** も研究されている。**ℝ/Λ 双対はこの adelic 構造の統計力学版である可能性**（要文献調査・検証）。転送行列のスペクトル ↔ 代数力学の系。

→ ここが「深く理解したい」核心。質問の方向: 積公式の正確な形、Mahler 測度・高さ（height）との対応、代数力学との辞書。

### 4.1 接地（2026-06-26 追記, cycle 4 T1）— ℝ 側は既知で深い

**自由エネルギー＝Mahler 測度**は確立した深い結果:
- スペクトル曲線 $P(z,w)=\det(wI-T(z))\in\mathbb{Z}[z^{\pm},w]$（$T(z)$＝Bloch 位相 $z$ つき転送行列）。
- $-\beta f=\log m(P)$（$m$＝Mahler 測度）。**Lind–Schmidt–Ward**（$\mathbb{Z}^d$ 作用のエントロピー＝Mahler 測度）の格子版。
- **Ising で精密化**: arXiv:2407.19531 / Phys. Rev. E 110, 054134 (2024)「Mahler measures, elliptic curves and L-functions for the free energy of the Ising model」。正方/三角/六角 Ising の自由エネルギー＝Laurent 多項式の Mahler 測度、特殊温度で楕円曲線 Hasse–Weil $L$、臨界点で Dirichlet $L$。
- 代数力学エントロピー＝Mahler 測度成長（arXiv:2109.08217）。

したがって **ℝ 側双対（自由エネルギー＝アルキメデス Mahler 測度）は既知**。本プロジェクトの寄与は **Λ 側（有限 N の $v_p$ 構造＝同じ $P$ の非アルキメデス/$p$ 進 Mahler 測度）との同定**（予想, D-U2 命題 A は厳密）。命題形は `integrable-lattice/outputs/reports/cycle4_T1_R_Lambda_mahler.md`。

質問の核（更新）: $p$ 進 Mahler 測度（Besser–Deninger, $p$ 進エントロピー）と $\mu_{\min}(p)$ の厳密対応。同一 $P$ のアルキメデス Mahler（ℝ自由エネルギー）と $p$ 進 Mahler（Λ の $\Phi$ 構造）を結ぶ積公式。

### 4.2 接地（2026-06-28 追記, cycle 6 T1）— Λ 側も既知理論だった

**Λ 側は予想でなく既存理論**: 周期点数 $a_L=\prod_{z^L=w^L=1}P\in\mathbb{Z}$ について、
- ℝ側 $\frac1{L^2}\log|a_L|\to m(P)$（アルキメデス Mahler＝自由エネルギー, LSW）。
- Λ側 岩澤塔 $L=p^n$ での $v_p(a_{p^n})$ の線形成長率 ＝ **Deninger の $p$ 進エントロピー** ＝ **Besser–Deninger の $p$ 進 Mahler 測度** ＝ **岩澤 $\mu_p$ 不変量**。

文献: Besser–Deninger "p-adic Mahler measures"; Deninger "p-adic entropy and a p-adic Fuglede–Kadison determinant"; "p-adic Mahler measure and ℤ-covers of links"（torsion 成長・Alexander 多項式・p 進エントロピー・μ_p の balance formula）。
⇒ ℝ/Λ 双対は **同一 $P$ の二つの素点での Mahler 測度**として両側とも確立理論に乗る。D-U2 はその有限・決定可能な顔。検証 `integrable-lattice/sagemath/check/cycle6_T1_padic_mahler/`, 命題 `integrable-lattice/outputs/reports/cycle6_T1_padic_mahler_grounding.md`。
注意: 例 $P=5-(z+1/z)-(w+1/w)$ は小素数で μ_p=0（p 進自明）。非自明 μ_p には $P\bmod p$ が p 冪根上に零点をもつ $P$ が必要。

---

## 5. 具体例（本セッション, 確立済み）

六頂点, 重み $(a,b,c)=(1,1,2)$, $L=2$: $\mathrm{charpoly}(T)=(x-6)(x+2)(x-2)^2$, 固有値 $\{6,-2,2,2\}$。

- $\mathbb{R}$ 側: $\lambda_{\max}=6$ ⇒ $-\beta f=\frac12\log 6$。
- $\Lambda$ 側: $v_2$: 全固有値 $v_2=1$ ⇒ $\mu_{\min}(2)=1$, 残差 $\equiv2$ ⇒ $v_2(Z_N)=N+2$。$v_3$: $v_3(6)=1$ だが $v_3(\pm2)=0$ ⇒ $\mu_{\min}(3)=0$, 周期2。
- 同じ $\{6,-2,2,2\}$ から、絶対値最大(6)が自由エネルギー、各 $p$ 進付値が $\Phi$ の素因数構造を出す。

他例（Potts q=3 など）も `sagemath/check/` 参照。

---

## 6. 未解決・質問の種（別セッション用）

1. 積公式の正確なステートメント: $\lambda_{\max}$ と $\{\mu_{\min}(p)\}_p$ を結ぶ大域恒等式はあるか（Mahler 測度・高さ経由か）。
2. SML 例外指数の意味（物理的・数論的）。
3. 代数力学（Lind–Schmidt–Ward, adelic Mahler 測度）との厳密な辞書。転送行列 ↔ $\mathbb{Z}^d$ 作用。
4. 非整数（代数的）重みへの拡張: 固有値は $\overline{\mathbb{Q}(x)}$、Newton 多角形・Mahler 測度はどうなるか。
5. 八頂点（楕円, theta 関数）の場合: 固有値が楕円的になり、ℝ/Λ 双対は崩れるか・別形になるか。
6. $\Lambda$（対数順序群）の言葉で双対を書くと何が言えるか（$\Phi$ は既に $\Lambda$、自由エネルギーは $\mathbb{R}$。双対を $\Lambda$ 内で定式化できるか）。
7. 形式検証: $\Lambda$ 側（決定可能）はそのまま機械検証可能。$\mathbb{R}$ 側との対応のどこまでが可算で言えるか。

---

## 7. 関連リポジトリ内資料

- `integrable-lattice/outputs/candidates/D-U2_vp_law_theorem_candidate.md`（$\Lambda$ 側の定理候補）。
- `integrable-lattice/sagemath/check/D-U2_padic_law/`（計算検証）。
- `docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md`（$\mathbb{R}$ 脱出の隔離・転送行列）。
- `docs/discussion/可算性の効用/`（可算/$\mathbb{R}$ = 決定可能性の境界）。

---

## 8. $\Lambda$-内部定式化（6-6 の確定, 層0/1）

6-6（双対を $\Lambda$ の言葉で書く）を、確立済みの定理 P だけで層0/1で確定する。$\mu_p$・積公式（層2）に非依存。6-1（積公式）はこの土台の上で初めて意味を持つ。

### 8.1 $\Lambda$ 側は単一の $\Lambda$-内部命題

**主張 1（$\Lambda$-傾き $M$ の well-defined 性）.** $T\in M_d(\mathbb{Z})$、$\det T\ne0$ とする。
$$M:=\sum_{p\in\mathcal P}\mu_{\min}(p)\,\ell_p\in\Lambda.$$
すなわち $\mu_{\min}(p)>0$ となる $p$ は有限個。
*証明*: $\mu_{\min}(p)=\min_i v_p(\lambda_i)>0$ なら全固有値が $v_p>0$、よって $v_p(\det T)=\sum_i v_p(\lambda_i)\ge d>0$、ゆえ $p\mid\det T$。$\det T\in\mathbb{Z}\setminus\{0\}$ の素因数は有限。∎（$\det T=0$ は $0$ 固有値を分離した $T'$ で同様。）

**主張 2（$\Lambda$-内部双対法則）.** 各 $N\in\mathbb{N}_{>0}$ に対し
$$\Phi_N=N\cdot M+R(N),\qquad R(N):=\sum_{p}r_p(N)\,\ell_p\in\Lambda,$$
$R(N)$ は各座標が $N$ について最終周期的。これは定理 P（$v_p(Z_N)=\mu_{\min}(p)N+r_p(N)$）の全 $p$ 集約。$R(N)\in\Lambda$（有限台）は固定 $N$ で $Z_N\in\mathbb{Z}_{>0}$ の素因数が有限だから。

⇒ 列 $(\Phi_N)_N\subset\Lambda$ は傾き $M\in\Lambda$ で**最終的に $\Lambda$-線形**。$\mathbb{R}$ 不使用。

### 8.2 $\mathbb{R}$ 脱出の隔離

**観察 3（スペクトル・データは可算）.** $\lambda_i\in\overline{\mathbb{Q}}$、$\bar\lambda_i\in\overline{\mathbb{Q}}$ ゆえ $|\lambda_i|_\infty^2=\lambda_i\bar\lambda_i\in\overline{\mathbb{Q}}\cap\mathbb{R}_{\ge0}$、したがって $|\lambda_i|_\infty\in\overline{\mathbb{Q}}\cap\mathbb{R}_{\ge0}$、$\lambda_{\max}\in\overline{\mathbb{Q}}\cap\mathbb{R}_{>0}$（絶対値も最大固有値も代数的・可算）。

**観察 4（唯一の $\mathbb{R}$ 脱出は $\log_{\mathbb{R}}$）.** $-\beta f=\frac1L\log_{\mathbb{R}}\lambda_{\max}$ で $\lambda_{\max}\in\overline{\mathbb{Q}}$ は可算、$\mathbb{R}$ へ出るのは $\log_{\mathbb{R}}:\overline{\mathbb{Q}}_{>0}\to\mathbb{R}$ 一つ。Baker により代数的 $\alpha\ne0,1$ で $\log_{\mathbb{R}}\alpha$ は超越、ゆえ一般に $\log_{\mathbb{R}}\lambda_{\max}\notin\overline{\mathbb{Q}}$。

**観察 5（同一スペクトルの二種の対数）.** 双対の両側は共通の有限多重集合 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$ の「対数」：$\Lambda$ 側は $\log:\mathbb{Q}_{>0}\to\Lambda$（$\min$-$v_p$ 集約 $=M$、厳密・可算）、$\mathbb{R}$ 側は $\log_{\mathbb{R}}:\overline{\mathbb{Q}}_{>0}\to\mathbb{R}$（$\max$-$|\cdot|_\infty$ の $\lambda_{\max}$、超越脱出）。

**観察 6（脱出が消える条件）.** $\lambda_{\max}\in\mathbb{Q}_{>0}$ のときに限り $\log_{\mathbb{R}}\lambda_{\max}=\sum_p v_p(\lambda_{\max})\ell_p\in\Lambda$ に落ち $\mathbb{R}$ 脱出が消える。例：六頂点 $(1,1,2),L=2$ で $\lambda_{\max}=6$、$-\beta f=\frac12(\ell_2+\ell_3)\in\Lambda\otimes\mathbb{Q}$。一般の可積分模型では $\lambda_{\max}$ は既約因子の Perron 根＝代数的無理数で脱出は不可避。

### 8.3 注意：$\lambda_{\max}\in\mathbb{Q}$ は可積分性・閉形式と独立（三軸の分離）

$\lambda_{\max}\in\mathbb{Q}$（固定 $L$ で charpoly が有理 Perron 根をもつ、$\iff$ 整数根、決定可能な算術的条件）は、次の三つの独立な軸のうち**軸 C のみ**の性質で、他を含意しない。

- **軸 A：可積分性**（層1）＝ 転送行列の族 $T(u)$ が Yang–Baxter を満たす。単一行列の一根が有理かどうかとは無関係。
- **軸 B：閉形式／可解性**（層2）＝ 熱力学極限 $L,N\to\infty$ の $-\beta f$ が明示式を持つか。これは別個の達成で、可積分でも保証されない（`07_Λ帰属と可解性は別.md` と同じ独立性）。
- **軸 C：有限 $L$ スペクトルの算術**（層0）＝ $\lambda_{\max}\in\mathbb{Q}$ など、charpoly の $\mathbb{Q}$ 上分解。

$\lambda_{\max}\in\mathbb{Q}$ が与えるのは「その有限 $L$ で $\mathbb{R}$ 脱出が消え $-\beta f\in\Lambda\otimes\mathbb{Q}$」だけ（観察 6）。極限 $L\to\infty$ は依然 $\mathbb{R}$ を要し、$\lambda_{\max}\in\mathbb{Q}$ は $L$ 増大で一般に崩れる不安定な性質。可積分性も閉形式も含意しない。

### 8.4 残タスク（確定に向けて）

1. 主張 1・2 を正式命題として（$\det T=0$ 縮退込みで）証明整備。
2. 観察 3–6 を命題化（$|\lambda_i|_\infty\in\overline{\mathbb{Q}}$、$\log_{\mathbb{R}}$ の超越性、脱出消滅条件 $\lambda_{\max}\in\mathbb{Q}$、三軸独立）。
3. $M\in\Lambda$（$\min$-$v_p$）と $\lambda_{\max}\in\overline{\mathbb{Q}}$（$\max$-$|\cdot|_\infty$）を、同一 $\{\lambda_i\}$ 上の二つの付値汎関数として並置する構造的定式化（積公式 6-1 を使わずに言える対）。
4. 2 から 6-7（形式検証）が従う：$\Lambda$ 側（主張 1・2）は決定可能・機械検証可能、$\mathbb{R}$ 側は $\log_{\mathbb{R}}\lambda_{\max}$ の一点のみ検証外、という境界の確定。
