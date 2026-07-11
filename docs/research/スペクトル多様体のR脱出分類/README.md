# スペクトル多様体の $\mathbb{R}$ 脱出分類（解説編）

$\mathbb{Z}^d$-周期系（$=\pi_1(T^d)$ の階数1表現）のスペクトル多様体 $\{P=0\}\subset(\mathbb{C}^\times)^d$、$P\in\mathbb{Z}[z_1^\pm,\dots,z_d^\pm]$ について、成長率 $m(P)=\int_{(S^1)^d}\log|P|$（自由エネルギー・エントロピー）の **$\mathbb{R}$ 脱出の型**を、機構つきで解説する。

- **具体例の一覧（約100件、表形式）**は [`../曲面群スペクトル曲線_球面とトーラス/04_スペクトル多様体カタログ_R脱出一覧.md`](../曲面群スペクトル曲線_球面とトーラス/04_スペクトル多様体カタログ_R脱出一覧.md)。
- 本フォルダは**その解説編**：Mahler 測度の厳密な定義（01）、各型 Ⅰ–Ⅳ の**なぜその型になるか**（02–04）。
- 立脚点は RΛ 双対（[`../R-Lambda-duality/`](../R-Lambda-duality/README.md)）：同一の整数的対象を各素点で読み、$\Lambda$ 側（各 $p$：点数・$\mu_{\min}$）は常に決定可能、$\mathbb{R}$ 側（$\infty$：$m(P)$）だけが脱出しうる。記号の所属集合を常に併記する（CLAUDE.md 厳密性原則）。

---

## 0. $\mathbb{R}$ 脱出の4分類（一枚に凝縮）

有限系は $-\beta f_L=\frac1L\log_{\mathbb{R}}\lambda_{\max}(L)$（$\lambda_{\max}\in\overline{\mathbb{Q}}$）、熱力学極限は $m(P)$。その値の**住処**と脱出の深さで4分類する。

| 型 | 値の住処 | 脱出の深さ | 決定可能性 | 中心素材 |
|---|---|---|---|---|
| **Ⅰ 脱出なし** | $\rho(\Lambda\otimes\mathbb{Q})$／整数 | なし | 完全に $\Lambda$-native | 円分・$\lambda_{\max}\in\mathbb{Q}$・表現数 |
| **Ⅱ 代数的 $\log$** | $\log_\mathbb{R}\overline{\mathbb{Q}}$ | $\log_\mathbb{R}$ 一点 | $\alpha\in\overline{\mathbb{Q}}$ まで | $d{=}1$ Mahler・hard hexagon・六角 SAW |
| **Ⅲ 特殊値** | $L(M,d)$（周期）| 構造化（Beilinson 正則子）| Euler 因子＝点数（可算）| dimer・Ising・Boyd・K3・CY |
| **Ⅳ 一般超越** | 周期（非特殊）| 閉形式なし | Newton・点数のみ可算 | 非可積分・Watson 積分・generic 高種数 |

**核心の主張（RΛ 双対）**：**型は $\{P=0\}$ の数論型で決まり、$\Lambda$ 側は全型で決定可能。決定不能・閉形式なしなのは $\mathbb{R}$ 側 $m(P)$ だけ（しかも型Ⅳ でのみ閉形式を失う）。**

---

## 1. 型Ⅲ の梯子：次元 $d$ で weight が上がる

型Ⅲ（最大の家系）は、$m(P)$ が **weight-$d$ の(準)モジュラー形式の $s=d$ 特殊値**になる。次元と weight が一本の梯子で対応する（[`03_型III_特殊値の梯子.md`](03_型III_特殊値の梯子.md)）。

| $d$ | $\{P=0\}$ | モチーフ weight | $L$ 値（$s=d$）| 代表・状態 |
|---|---|---|---|---|
| 2 有理 | 曲線（種数0）| Dirichlet (wt1) | $L(\chi,2)$, dilog | dimer・Smyth（✓）|
| 3 有理 | 曲面（有理）| $\zeta$ | $\zeta(3)$ | Smyth 3-var（✓）|
| 2 楕円 | 曲線（種数1）| wt-2 $=L(E,s)$ | $L(E,2)\sim L'(E,0)$ | Boyd $n(k),g(k)$（一部✓）|
| 3 K3 | 曲面（K3）| **wt-3 newform** | $L(f,3)$ | Bertin・Samart（✓）|
| 4 CY | 3-fold（CY）| **wt-4 newform** | $L(f,4)$ | Papanikolas–RS（✓）|

$T^2$ の楕円（$d=2$ 段）→ $T^3$ の K3（$d=3$ 段）→ $T^4$ の CY（$d=4$ 段）。同一機構（LSW＋Beilinson 予想）が次元に沿って昇る。

---

## 2. ファイル一覧

- [`01_Mahler測度の厳密な定義.md`](01_Mahler測度の厳密な定義.md) — 対数/乗法 Mahler 測度、測度と所属集合、$d=1$ の代数的公式 $(\ast)$ と Jensen 同値（証明つき）、$d\ge2$ の収束定理、基本性質（加法性・Kronecker・Lehmer・Boyd–Lawton 極限）、$\mathbb{R}$ 脱出がどこで起きるか。
- [`02_型I_II_脱出なしと代数的log.md`](02_型I_II_脱出なしと代数的log.md) — 型Ⅰ（$\in\Lambda\otimes\mathbb{Q}$・整数：円分・$\lambda_{\max}\in\mathbb{Q}$・表現数 #88–92）と型Ⅱ（代数的 $\log$：全 $d{=}1$ Mahler、hard hexagon、square ice、六角 SAW）。Pisot vs Salem、$\alpha^n\in\mathbb{Q}$ か否かで型Ⅰ/Ⅱ が分かれる境。
- [`03_型III_特殊値の梯子.md`](03_型III_特殊値の梯子.md) — 型Ⅲ（$L$ 値）を weight ladder で。Beilinson 正則子＝Mahler 測度、weight-1（Dirichlet/dilog/$\zeta(3)$）→ wt-2（楕円 $L'(E,0)$、Boyd）→ wt-3（K3、Bertin–Samart）→ wt-4（CY、Papanikolas–RS）。証明/予想の分別。
- [`04_型IV_一般超越.md`](04_型IV_一般超越.md) — 型Ⅳ（周期だが特殊 $L$ 値でない）：非可積分（hard square・SAW・Klarner）、Watson 積分（$\mathbb{Z}^{3,4}$ 全域木）、連続母数（八頂点）、generic 高種数（#45）。**$\Lambda$ 側は型Ⅳ でも決定可能**という RΛ の最シャープな非対称。

---

## 3. RΛ 双対での総括

1. **$\Lambda$ 側は全型で決定可能**：$P\bmod p$ 点数・Newton 多角形・$\mu_{\min}(p)$・（非可換なら表現数・指標多様体点数）は有限手続き。型Ⅳ でも $\{P=0\}$ の Hasse–Weil $L$ の Euler 因子は各 $p$ で組める。
2. **型＝数論型**：有理→Dirichlet、楕円→$L'(E,0)$、K3→$L(f,3)$、CY→$L(f,4)$（型Ⅲ）；代数的潰れ→Ⅱ/Ⅰ；非特殊→Ⅳ。
3. **可解性の特徴づけ**（[`../R-Lambda-duality §9`](../R-Lambda-duality/README.md)）：型Ⅲ（$\iff\{P=0\}$ 数論的特殊 $\iff m(P)$ が $L$ 特殊値）が「解ける系の族」。**分類子は YBE でなくスペクトル多様体の数論**（hard hexagon＝可積分だが型Ⅱ、全域木＝非可積分だが型Ⅲ）。
4. **双対の顔**：同一 $L$ 函数を $\infty$ で読めば $m(P)$（自由エネルギー・アルキメデス）、各 $p$ で読めば Euler 因子（$\Lambda$-native）。

---

## 4. 関連ドキュメント

- カタログ本体：[`../曲面群スペクトル曲線_球面とトーラス/04_スペクトル多様体カタログ_R脱出一覧.md`](../曲面群スペクトル曲線_球面とトーラス/04_スペクトル多様体カタログ_R脱出一覧.md)
- スペクトル曲線の定義・次元梯子：[`../数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md`](../数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md)
- Mahler 測度＝$L$ 値の数論：[`../Boyd-Deninger-Beilinson/`](../Boyd-Deninger-Beilinson/README.md)
- 数え上げエントロピー＝周期のプログラム：[`../数え上げエントロピーと特殊値/README.md`](../数え上げエントロピーと特殊値/README.md)
- RΛ 双対の枠組み：[`../R-Lambda-duality/README.md`](../R-Lambda-duality/README.md)
- 任意次元 $T^d$ の理論：[`../曲面群スペクトル曲線_球面とトーラス/03_任意次元トーラス_Zd.md`](../曲面群スペクトル曲線_球面とトーラス/03_任意次元トーラス_Zd.md)
