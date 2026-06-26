# ℝ/Λ 双対（概要・現状まとめ）

別セッションでの質問・深掘り用のまとめ。出どころは `integrable-lattice` の cycle 2（方向 D-U2）で観察した現象。
**確立済み（SageMath で計算検証）** と **概念的（解釈・要検証）** を明確に分ける。

記号の集合帰属を常に併記する（CLAUDE.md 厳密性原則）。$\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ は対数順序群（`docs/discussion/対数順序群上の統計力学/`）。

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
- $\mu_{\min}(p)$ = charpoly の **$p$ 進 Newton 多角形の最小傾き** = 固有値の**最小 $p$ 進付値**。
- $r_p(N)$ = 最終周期的な残差（ただし Skolem–Mahler–Lech 由来の疎な例外指数でスパイクしうる。特殊素数 $p\mid$（模型の対称性位数）で周期増大）。

住処は $\Lambda$（係数は $\mathbb{Z}$）、決定可能・有限 $N$・$\mathbb{R}$ 不使用。支配するのは $|\lambda|_p$（最小付値固有値）。

機構: $Z_N=p^{\mu_{\min}N}\sum_i u_i^N$（$u_i=\lambda_i/p^{\mu_{\min}}$、最小付値群は $p$ 進単位）。単位和は単位係数の線形漸化列で mod $p^k$ 周期的 ⇒ その $v_p=r_p$ が最終周期。

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
