# 曲面群のスペクトル曲線：球面とトーラス（$g=0,1$ の具体例）

種数 $g$ の閉曲面 $\Sigma_g$（および穴あき）の基本群 $\pi_1(\Sigma_g)$ に「対応するスペクトル曲線」を、**球面 $g=0$（穴あき含む）とトーラス $g=1$** について具体例で書く。既存の [`数え上げエントロピーと特殊値/07_曲面群のスペクトル曲線_Λ言語.md`](../数え上げエントロピーと特殊値/07_曲面群のスペクトル曲線_Λ言語.md) は $g\ge2$（双曲・非可換 Fuchsian）を扱ったので、本フォルダはその欠けている両端 $g=0,1$ を埋める。

RΛ 双対の立場（[`R-Lambda-duality/`](../R-Lambda-duality/)）を貫く：**同一の整数的対象を各素点で読む**。可算・決定可能な Λ-native な本体（表現数・指標多様体の点数・$P\in\mathbb{Z}[z^\pm,w^\pm]$）と、その $\mathbb{C}$ での顔（Hitchin スペクトル曲線）とを常に分ける。記号の所属集合を併記する（CLAUDE.md 厳密性原則）。

以下、$d$（本フォルダでは表現／Higgs 束の**階数** $N$）は $N\ge2$。$N=1$（アーベル・GL$_1$）は曲線が退化するが、**トーラスに限っては $N=1$ こそが RΛ 双対の基底**（下記）なので別扱いする。

---

## 0. 一言で：トーラスは枠組みの中心、球面は穴が要る

| $g$ | 曲面 | $\pi_1$ | $\mathbb{C}$ 側スペクトル曲線（階数 $N$）の姿 | RΛ での位置 |
|---|---|---|---|---|
| **0** | 球面 $S^2$ | $1$（自明）| **存在しない**（$\deg K_{\mathbb{P}^1}=-2<0$, Higgs 束が空）| 退化端。穴で救済 |
| **0** | $n$ 点穴あき球面 | 自由群 $F_{n-1}$ | $\lambda^2=a_2$（$a_2$＝極つき2次微分）, 種数 $g_S=n-3$ | 自由群＝Deligne–Simpson |
| **1** | トーラス $T^2$ | $\mathbb{Z}^2$（アーベル）| $N$ 重被覆 $\lambda^N+c_1\lambda^{N-1}+\dots+c_N=0$（$c_i\in\mathbb{C}$）| **$\mathbb{Z}^d$($d{=}2$) 基底そのもの** |
| $\ge2$ | $\Sigma_g$（双曲）| 非可換 Fuchsian | $\Sigma_g$ の $N$ 重分岐被覆, 種数 $N^2(g-1)+1$ | doc 07（既出）|

**トーラスが特別**：$\pi_1(T^2)=\mathbb{Z}^2=\mathbb{Z}^d$（$d=2$）はアーベルで、RΛ 双対の全機構（[`数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md`](../数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md)）がまさにこの群の上に建っている。階数 $N=1$（GL$_1$）で指標トーラス $\mathrm{Hom}(\mathbb{Z}^2,\mathbb{C}^\times)=(\mathbb{C}^\times)^2$ が Bloch トーラスに一致し、スペクトル曲線 $P(z,w)=\det A(z,w)\in\mathbb{Z}[z^\pm,w^\pm]$（dimer・Ising）を**そのまま**与える。→ [`01_トーラス_π1=Z2.md`](01_トーラス_π1=Z2.md)

**球面は穴が要る**：$\pi_1(S^2)=1$ で自明。$\mathbb{P}^1$ 上 $\deg K=-2<0$ ゆえ非自明 Higgs 束が無い（種数公式 $N^2(g{-}1)+1=1-N^2<0$ が退化の別証）。穴（放物・有理型構造）を入れて $K(D)$、$\deg K_{\mathbb{P}^1}(D)=-2+n\ge0\iff n\ge2$ で初めて曲線が立つ。$\pi_1$ は自由群 $F_{n-1}$、階数2で $\lambda^2=a_2$、**4点穴あきで種数 $g_S=1$＝楕円曲線＝Painlevé VI** が核心の具体例。→ [`02_球面と穴あき球面_自由群.md`](02_球面と穴あき球面_自由群.md)

---

## 1. 三種の「スペクトル曲線」を混同しない

曲面群まわりで「スペクトル曲線」は三つの別物を指しうる。所属集合で区別する。

1. **Betti／指標多様体側**（離散群 $\pi_1$ の表現）：$\mathrm{Hom}(\pi_1,G)/\!\!/G$。複素構造不要、位相的・組合せ的。トーラスなら可換対の多様体 $\{(A,B):AB=BA\}/\!\!/G$、有限体点数は決定可能（Λ-native）。
2. **Dolbeault／Hitchin 側**（曲面上の Higgs 束）：$\widetilde\Sigma=\{\det(\lambda-\Phi)=0\}\subset\mathrm{Tot}(K)$。ここに複素構造・$\wp/\theta$ 関数が入り、$\mathbb{C}$-解析（非可算）が本質化する箇所。
3. **Bloch／Mahler 側**（$\mathbb{Z}^d$-周期作用素）：$P(z,w)=\det A(z,w)\in\mathbb{Z}[z^\pm,w^\pm]$、$(\mathbb{C}^\times)^2$ 内曲線。トーラスの階数1で 1 と 3 が一致する。

非可換 Hodge（Hitchin 1987, Simpson 1992）は同一 $E$ で 1↔2 を実解析的に同一視するが、**双正則ではなく別対象**。$\mathbb{C}$-解析（調和計量・$L^2$）が真に要るのはこの Betti↔Dolbeault 対応の一点のみで、代数的言明（曲線の方程式・指標多様体・点数）はすべて可算・代数的データに載る。

---

## 2. RΛ 双対との接続（各ファイル共通の骨子）

同一対象を二素点で読む双対を、$g=0,1$ で具体化する。

| | Λ 側（$p$：可算・決定可能）| $\mathbb{R}$ 側（$\infty$：唯一の脱出）|
|---|---|---|
| **トーラス $N=1$** | $P\bmod p$ 点数・$p$ 進 Newton 多角形（$\mu_{\min}$）| $m(P)=\int_{\mathbb{T}^2}\log|P|$（自由エネルギー・Mahler 測度）|
| **トーラス $N\ge2$** | 可換対の $\mathbb{F}_q$ 点数（Feit–Fine, $k(GL_N)$）| Hitchin ファイバー体積・楕円 CM の作用積分 |
| **穴あき球面** | 自由群 $\to G$ 表現数＝Deligne–Simpson 解の数, 指標多様体点数 | 放物 Higgs モジュライの体積・Painlevé $\tau$ |

Λ 側はすべて有限データ（$G$ の指標表・$\mathbb{F}_q$ 点数・整数多項式 $P$）から決まり、素因数分解 $\Phi=\log(\cdot)\in\Lambda$ も決定可能。$\mathbb{C}$ の Hitchin 曲線・楕円関数・Witten/Hitchin 体積がアルキメデスの顔。

---

## 3. ファイル一覧

- [`01_トーラス_π1=Z2.md`](01_トーラス_π1=Z2.md) — $\pi_1(T^2)=\mathbb{Z}^2$。**$N=1$：Bloch トーラス $(\mathbb{C}^\times)^2$ 上の $P(z,w)$＝dimer/Ising Mahler 曲線（RΛ 基底）**。$N\ge2$：可換対多様体 $\mathrm{Sym}^N((\mathbb{C}^\times)^2)$（Florentino–Lawton）、楕円曲線 $E$ 上 Higgs 束のスペクトル曲線 $\lambda^N+c_1\lambda^{N-1}+\dots+c_N=0$（$N$ 枚の $E$、étale）、1 点穴で楕円 Calogero–Moser（Krichever Lax・D'Hoker–Phong SW 曲線）。$\mathbb{F}_q$ 点数（Feit–Fine）。
- [`02_球面と穴あき球面_自由群.md`](02_球面と穴あき球面_自由群.md) — $S^2$ の退化（$\deg K=-2$）と穴による救済。$n$ 点穴＝自由群 $F_{n-1}$、Deligne–Simpson／Crawley-Boevey。放物 Higgs の $\lambda^2=a_2$、種数 $g_S=n-3$。**$n=3$：剛性・超幾何（Katz、点）／$n=4$：楕円スペクトル曲線＝Painlevé VI（Manin 楕円形・Levin–Olshanetsky・Takasaki）**。

---

## 4. 主要文献

- N. Hitchin (1987) *Stable bundles and integrable systems*, Duke 54, 91–114; *The self-duality equations on a Riemann surface*, PLMS 55（種数公式・$\deg K$ 障害）。
- A. Beauville, M. S. Narasimhan, S. Ramanan (1989) Crelle 398, 169–179（スペクトル対応）。
- M. Atiyah (1957) *Vector bundles over an elliptic curve*, PLMS 7（$E$ 上の束＝$\mathrm{Sym}^N E$）。
- C. Florentino, S. Lawton (2014) *Topology of character varieties of Abelian groups*, Topology Appl. 173（arXiv:1301.7616; $\mathrm{Hom}(\mathbb{Z}^r,G)/\!\!/G\cong T^r/W$）。
- W. Feit, N. Fine (1960) *Pairs of commuting matrices over a finite field*, Duke 27, 91–94（$\mathbb{F}_q$ 点数）。
- I. Krichever (1980) *Elliptic solutions of the KP equation…*, Funct. Anal. Appl. 14（楕円 CM の Lax 対）。
- N. Nekrasov (1996) *Holomorphic bundles and many-body systems*, CMP 180（arXiv:hep-th/9503157; 楕円 CM＝1 点穴 Hitchin）。
- E. D'Hoker, D. Phong (1998) *Calogero–Moser systems in SU(N) Seiberg–Witten theory*, Nucl. Phys. B513（arXiv:hep-th/9709053; SW スペクトル曲線）。
- A. Treibich, J.-L. Verdier (1990) *Solitons elliptiques*, Grothendieck Festschrift III（楕円 CM 曲線の代数幾何的分類）。
- R. Kenyon, A. Okounkov, S. Sheffield (2006) *Dimers and amoebae*, Ann. Math. 163（arXiv:math-ph/0311005; $P=\det K$, Mahler 測度）。
- W. Crawley-Boevey (2003) Duke 118, 339–352; Crawley-Boevey–Shaw (2006) Adv. Math. 201（arXiv:math/0404186）（Deligne–Simpson）。
- N. Katz (1996) *Rigid Local Systems*, Annals of Math. Studies 139（剛性・middle convolution・超幾何）。
- Yu. Manin (1998) *Sixth Painlevé equation, universal elliptic curve…*, AMS Transl. 186（arXiv:alg-geom/9605010; $P_{VI}$ 楕円形）。
- A. Levin, M. Olshanetsky (1997) *Painlevé–Calogero correspondence*（arXiv:alg-geom/9706010）; K. Takasaki (1999) JMP 40（arXiv:math/9905101）。
- D. Gaiotto, G. Moore, A. Neitzke (2013) *Wall-crossing, Hitchin systems…*, Adv. Math. 234（arXiv:0907.3987; $\lambda^2=\phi_2$）。
- T. Hausel, F. Rodriguez-Villegas (2008) *Mixed Hodge polynomials of character varieties*, Invent. 174（arXiv:math/0612668）。
