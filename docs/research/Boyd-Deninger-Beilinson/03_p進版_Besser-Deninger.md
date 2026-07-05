# 03 $p$ 進版（Besser–Deninger）と R-Λ 双対の $\Lambda$ 側

アルキメデス（$\infty$）の Mahler 測度＝$L$ 値の**非アルキメデス（$p$ 進）版**。R-Λ 双対の $\Lambda$ 側（$\mu_p$）はここに乗る。

## $p$ 進 Mahler 測度（Besser–Deninger 1999）

アルキメデス Mahler 測度は $m(P)=\int_{\mathbb{T}^n}\log|P|\,d\mu$（$\mathbb{R}$ 値、実対数 $\log$）。Besser–Deninger は $\log$ を **$p$ 進対数** $\log_p:\mathbb{C}_p^\times\to\mathbb{C}_p$（Iwasawa 分岐, $\log_p p=0$ と正規化）に置き換え、$\mathbb{T}^n$ 上の積分を **$p$ 進的に意味づけ**た $p$ 進 Mahler 測度
$$
m_p(P)\in\mathbb{C}_p
$$
を定義した（"$p$-adic Mahler measures", *J. reine angew. Math.* 517, 1999）。素朴な積分は $p$ 進では収束しないため、実際には**Coleman 積分／syntomic 正則子**を用いて曲線 $\{P=0\}$ 上で定義する。

- 住処：$\mathbb{C}_p$（$\mathbb{Q}_p$ の代数閉包の完備化、非可算だが**アルキメデスとは別の位相**）。
- 核となる超越函数：$p$ 進ダイログ **$\mathrm{Li}_{2,p}$**（Coleman の $p$ 進多重対数）、種数 1 では**$p$ 進楕円ダイログ**。アルキメデスの $D,D_E$ の $p$ 進対応物。

## syntomic 正則子と $p$ 進 $L$ 値

Beilinson の枠組み（ファイル 01）の $p$ 進版：
$$
\mathrm{reg}_p:H^{i+1}_{\mathcal M}(X,\mathbb{Q}(n))\longrightarrow H^{i+1}_{\mathrm{syn}}(X,n)\quad(\text{syntomic コホモロジー}).
$$
**$p$ 進 Beilinson 予想**（Perrin-Riou, Besser, Colmez ほか）: syntomic 正則子 $\mathrm{reg}_p$ の行列式が **$p$ 進 $L$ 函数の特殊値** $L_p(h^i(X),n)$ に等しい（$\bmod\ \mathbb{Q}^\times$）。楕円曲線 $E$ では
$$
\mathrm{reg}_p\{x,y\}\equiv r\cdot L_p'(E,0)\pmod{\mathbb{Q}^\times}
$$
（$L_p$＝$E$ の $p$ 進 $L$ 函数, Mazur–Swinnerton-Dyer）。すなわち **$m_p(P)$＝$p$ 進 $L$ 値**——アルキメデス側 $m(P)=rL'(E,0)$ の完全な $p$ 進鏡像。

**状態**: $p$ 進 Beilinson 予想も一般には予想。Besser らが特定例で syntomic 正則子＝$p$ 進 $L$ 値を証明。

## Deninger の $p$ 進エントロピー

Deninger は $\mathbb{Z}^n$ 作用の**$p$ 進エントロピー**を導入し（"p-adic entropy and a p-adic Fuglede–Kadison determinant"）、これが $p$ 進 Mahler 測度 $m_p(P)$ に一致することを示した。アルキメデス側の
$$
h_{\mathrm{top}}(\alpha_P)=m(P)\quad(\text{Lind–Schmidt–Ward, 位相的エントロピー}=\text{Mahler 測度})
$$
の $p$ 進版。$p$ 進 Fuglede–Kadison 行列式が $p$ 進版の「$\log|\det|$」を与える。

## R-Λ 双対（$\Lambda$ 側）との対応

`docs/research/R-Lambda-duality/` の記号との辞書。

| R-Λ 双対（$\Lambda$ 側）| Besser–Deninger |
|---|---|
| $\Phi_N=\log Z_N\in\Lambda$ の $\ell_p$ 係数 $v_p(Z_N)$ | $p$ 進付値データ（Newton 多角形）|
| 傾き $\mu_{\min}(p)$（固定 $L$, 層0）| 有限近似の $p$ 進付値 |
| 岩澤塔 $L=p^n$ の $\mu_p$ 不変量（層2, §4.2）| $p$ 進エントロピー ＝ $m_p(P)$ ＝ 岩澤 $\mu$ |
| 周期点数 $a_L=\prod_{z^L=w^L=1}P$ の $p$ 部の成長 | $p$ 進 Mahler 測度の有限近似 |

**要点**: R-Λ 双対の「$\Lambda$ 側は自由エネルギーの $p$ 進鏡像」という主張の数論的実体が、**Besser–Deninger の $p$ 進 Mahler 測度＝$p$ 進 $L$ 値**。アルキメデス $m(P)$（自由エネルギー, 実 $L'(E,0)$）と $p$ 進 $m_p(P)$（$p$ 進エントロピー, $L_p'(E,0)$）は、**同一の楕円曲線 $E=\{P=0\}$ の $L$ 函数（動機）の、異なる素点での特殊値**。

$$
\boxed{\ \underbrace{m(P)=rL'(E,0)}_{\infty,\ \text{自由エネルギー}}\quad\Longleftrightarrow\quad\underbrace{m_p(P)=r\,L_p'(E,0)}_{p,\ p\text{ 進エントロピー}=\Lambda\text{ 側}}\ }
$$

これが R-Λ 双対 §6-1「大域恒等式」の成熟形：素朴な積公式ではなく、**adelic な $L$ 函数の各素点での特殊値の族**。R-Λ 双対 §9.2 の「$\Lambda$ 側は $L$ 函数の局所因子を決定可能に与えるプローブ」は、周期点数 $a_L$・$P\bmod p$ の点数が $L_p$ の Euler 因子を組み立てる、という意味でここに接続する。

## 決定可能性の観点（本リポジトリの立場）

- アルキメデス側 $L'(E,0)$：非可算・解析的（実の $L$ 微分値）。
- $p$ 進側 $L_p'(E,0)$：$p$ 進だが、**Euler 因子 $a_p=p+1-\#E(\mathbb{F}_p)$ は有限体点数で決定可能・機械計算可能**。個々の局所因子は可算・決定可能。
- ゆえ「$\Lambda$ 側（$p$ 進・点数）は決定可能プローブ、アルキメデス側（自由エネルギーの閉形式）は $\mathbb{R}$ 脱出」という R-Λ 双対の非対称性が、この理論の $\infty$/$p$ の非対称性として厳密に現れる。可解性の**検出**（数論型の判定）は決定可能な $p$ 側で進められる、というのが本リポジトリの狙いと整合する。
