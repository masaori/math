# cycle 15 / T1: Monsky–Cuoco–Monsky の形と主要係数 $m_0=v_p(\mathrm{content})$ の確認

スクリプト `monsky_shape.sage`、出力 `monsky_shape.out`（SageMath 10.6、`sage monsky_shape.sage`）。

本体は `outputs/reports/cycle15_T1_kataoka_and_general_P.md`。
**本ディレクトリは既知定理（Kataoka arXiv:2606.03579 Theorem 2.1 / 2.3、
＝Monsky Theorem 5.6 ＋ Cuoco–Monsky Theorem 1.7）の帰結を数値で確認するものであって、
定理を証明したのではない。**

## 対象（何を検証したか）

$P\in\mathbb{Z}[z,w]$、$a_L:=\prod_{z^L=1,w^L=1}P(z,w)$、$f:=P(1+T,1+S)$ とする。
$a_{p^n}=\prod_{\chi\in\widehat{\Gamma_n}}\chi(f)$ なので Kataoka Theorem 2.1 が直接適用でき、
$d=2$ では $n\gg0$ で
$$v_p(a_{p^n})=m_0\,p^{2n}+l_0\,n\,p^{n}+\mu_1 p^{n}+\lambda_1 n+\nu,\qquad m_0=m_0(f),\ l_0=l_0(f).$$

1. **補題 D**: $v_p(\mathrm{content}_{z,w}P)=v_p(\mathrm{content}_{T,S}f)$
   （$z\mapsto1+T$ が $\mathbb{Z}$ 上の環同型なので content が保たれる）。
   これにより Kataoka Definition 2.2 の $m_0(f)$（$f$ を割り切る $p$ の最大冪）が
   $v_p(\mathrm{content}_{z,w}P)$ として計算できる。
2. **主要項**: $v_p(a_{p^n})-m_0p^{2n}$ が $p^{2n}$ より低位に留まるか。
3. **形への同定**: $n\ge1$ の 5 段で 5 係数を解き、同定された $m_0$ が content 由来の値と一致するか。

## 手順（どのスクリプトを何の設定で実行したか）

`monsky_shape.sage` を実行する。設定はスクリプト内に固定。

- 対象 $P$: 10 個。本プロジェクトの主例 $5-(z+z^{-1})-(w+w^{-1})$ とその $2,4,8$ 倍、
  $6-z-w$、$2+3z+3w$、$7-2z-2w$、$3\times(6-z-w)$、$9\times(6-z-w)$、$2\times(7-2z-2w)$。
  content が $p$ で割れる例を意図的に入れてある（主要項が見えるようにするため）。
- 素数 $p\in\{2,3,5,7\}$（(1)）、$p\in\{2,3\}$（(2)）、$p=2$（(3)）。
- $a_L$ は終結式 $\mathrm{Res}_z(z^L-1,\mathrm{Res}_w(w^L-1,P))$ で**厳密整数**計算
  （$z^L-1$, $w^L-1$ はモニックなので終結式が積を厳密に与える）。浮動小数点も $\mathbb{Q}_p$ も使わない。
- $n$ の範囲: (1)(2) は $L^2\le300$、(3) は $p=2$ で $n\le5$。

## 結論（実行ログから読み取れる事実）

- **(1)** 10 個の $P$ × 4 素数で $v_p(\mathrm{content}_{z,w}P)=v_p(\mathrm{content}_{T,S}f)$、**不一致 0 件**。
- **(2)** content $>1$ の 5 例では $v_p(a_{p^n})=m_0\,p^{2n}$ が**厳密に**成立（差がすべて 0）:
  $2\times$ は $1,4,16,64$（$=1\cdot4^n$）、$4\times$ は $2,8,32,128$（$=2\cdot4^n$）、
  $8\times$ は $3,12,48,192$（$=3\cdot4^n$）、$3\times(6-z-w)$ の $p=3$ は $1,9,81$（$=1\cdot9^n$）、
  $9\times(6-z-w)$ の $p=3$ は $2,18,162$（$=2\cdot9^n$）。
  content $=1$ の例では $m_0=0$ で、差は元の値そのもの（$O(np^n)$ の増大）。
- **(3)** $n\ge1$ の 5 段から同定した $(m_0,l_0,\mu_1,\lambda_1,\nu)$ の第 1 成分が、
  content から独立に決めた $m_0$ と 3 例すべてで一致。
  $6-z-w$（$p=2$）と $3\times(6-z-w)$（$p=2$）は $n=0$ で外れる（$n\gg0$ の主張なので矛盾しない）。
  $2+3z+3w$ は $n=0$ から一致。

## 限界

- **有限標本である。** ただし形と主要係数は Kataoka Theorem 2.1 / 2.3 という**既知定理の帰結**であり、
  本ディレクトリはその適用が正しいことの確認にすぎない。数値一致を証明の代わりにしていない。
- **$l_0$ は本スクリプトで独立に計算していない**（同定で出た値を見ているだけ）。
  なお report 初版が挙げた「$\bar f$ の $\mathbb{P}^1(\mathbb{F}_p)$ 有理線形因子の重複度の和」というレシピは
  **誤りで、上限しか与えない**（report §4.2 の反例 $P=z+w^2-2w$, $p=3$）。$l_0$ の計算可能性は未解決。
- (3) の同定は 5 未知数を 5 方程式で解いたもので、**同定であって証明ではない**。
- **新規性は主張しない**（report §6）。Kataoka の §4–§6 と、Monsky / Cuoco–Monsky の原論文本文は未取得。
