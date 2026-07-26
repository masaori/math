# cycle 13 / T3 Pure: 判定式 $(★)$ $(☆)$ の証明ステップの機械検証

## 対象

証明本体は [`outputs/reports/cycle13_T3_mu_content_criterion_proof.md`](../../../outputs/reports/cycle13_T3_mu_content_criterion_proof.md)。
本ディレクトリはその**証明の各補題・定理を具体例で照合する**ためのもので、証明そのものではない。

証明する対象（cycle 12 T3 `cycle12_T3_nonzero_mu_p/` で数値照合のみだった 2 つ）:

- $(★)$ $\;N\cdot\kappa(X_N)=\kappa(X)\prod_{\zeta^N=1,\zeta\neq1}\det L(\zeta)$
- $(☆)$ $\;\mu_\ell=v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr)$

記号（$X$ 有限連結多重グラフ、voltage $\alpha:E\to\mathbb{Z}$、導来グラフ $X_N$、voltage ラプラシアン $L(z)$、
全域木数 $\kappa$）はすべて証明本体 §1 に定義がある。グラフの表現規約は cycle 12 の
`cycle12_T3_nonzero_mu_p/` と同一（辺は `(u, v, a)` の list、`u == v` はループ、`a` が voltage）。

## ファイル

- `proof_steps.sage` — 検証スクリプト（SageMath 10.6）
- `proof_steps.out` — 実行ログ

## 手順

このディレクトリで実行する。

```
cd integrable-lattice/sagemath/check/cycle13_T3_criterion_proof
sage proof_steps.sage
```

乱数種は `set_random_seed(20260726)` で固定してあるので、乱択グラフを含めて出力は再現する。

## 検証項目と結論

| Step | 検証内容 | 証明本体の対応 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_N})=\prod_{\zeta^N=1}\det(xI-L(\zeta))$ を $\mathbb{Q}(\zeta_N)[x]$ 上の厳密等式として照合 | 補題 A（DFT ブロック対角化） | 312 件、不一致 0 |
| 2 | $c(X_N)=\sum_{\zeta^N=1}\dim\ker L(\zeta)$ | 補題 B | 416 件、不一致 0 |
| 3 | $X_N$ 連結 $\iff \gcd(N,g_X)=1$（$g_X$ = 基本閉路 voltage の gcd） | 補題 C | 552 件、不一致 0 |
| 4 | $N\kappa(X_N)=\kappa(X)\prod_{\zeta\neq1}\det L(\zeta)$。左辺は導来グラフを構成して Kirchhoff 余因子、右辺は終結式で、**独立に**厳密計算 | 定理 1 $=(★)$ | 624 件（うち $X_N$ 非連結 129 件）、不一致 0 |
| 5 | $\mathrm{content}_z(\det L)=\mathrm{content}_z(P)=\mathrm{content}_T(P(1+T))$、および $\mu_{\text{Weierstrass}}=v_\ell(\mathrm{content})$ | 補題 D、定理 3 $=(☆)$ | 45 グラフ × 5 素数、不一致 0 |
| 6 | $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+(\lambda_{\mathrm W}-1)n+\nu$。$\mu,\lambda_{\mathrm W}$ は $\det L(1+T)$ の係数だけから（$\kappa_n$ を一切見ずに）決め、$\nu$ は $n=n_{\max}$ で 1 回だけ決める | 定理 2、定理 3 | 明示 8 グラフの 22 塔で全 $n$ 一致。乱択 63 塔で $n_0$（漸近が成立し始める段）の分布は $0$:51, $1$:3, $2$:4, $3$:5 件 |
| 7 | $v_\ell(\mathrm{content})=0$ なのに $\ell\nmid N$ の段で $v_\ell(\kappa(X_N))>0$ になる witness の提示 | §9.4（適用範囲の限界） | 6 件提示 |

対象グラフは、cycle 12 の例 1–6（$\mu_2=2\,\&\,\mu_3=1$ / $\mu_2=4$ / $\mu_{23}=1$ / 3 頂点 / $\mu_3=2$ / $\mu_5=1$）に加えて、

- $\chi(X)=0$ の bouquet（1 頂点 1 ループ）— 証明が $\chi(X)\neq0$ を必要としないことの確認
- $\det L\equiv0$ の退化例（voltage 全部 $0$ の三角形など）
- $\ell$-塔が非連結になる退化例（voltage $2$ のループのみ、$\ell=2$）
- 乱択 40 件（頂点 $\le3$、辺 $\le6$、voltage $\in[-3,3]$、ループ・多重辺込み）

の計 52 件。

## 実行ログの要点

`proof_steps.out` の Step 6 の表より（$\mu,\lambda_{\mathrm W}$ は $\det L(1+T)$ から、$\mathrm{ord}_\ell(\kappa_n)$ は Kirchhoff から）:

| グラフ | $\ell$ | $\mu$ | $\lambda_{\mathrm W}$ | $\lambda=\lambda_{\mathrm W}-1$ | $\nu$ | $\mathrm{ord}_\ell(\kappa_n)$ |
|---|---|---|---|---|---|---|
| 例1 | 2 | 2 | 2 | 1 | $-2$ | 0, 3, 8, 17, 34, 67, 132 |
| 例1 | 3 | 1 | 2 | 1 | 0 | 1, 4, 11, 30, 85 |
| 例2 | 2 | 4 | 2 | 1 | $-2$ | 2, 7, 16, 33, 66, 131, 260 |
| 例3 | 23 | 1 | 2 | 1 | $-1$ | 0, 23 |
| 例4 | 2 | 4 | 2 | 1 | $-2$ | 2, 7, 16, 33, 66, 131 |
| 例5 | 3 | 2 | **4** | **3** | $-2$ | 0, 7, 22, 61 |
| 例6 | 5 | 1 | 2 | 1 | $-1$ | 0, 5, 26 |
| bouquet 1ループ（$\chi=0$） | 2 | 0 | 2 | 1 | 0 | 0, 1, 2, 3, 4, 5, 6 |

cycle 12 では $(\mu,\lambda,\nu)$ を $\kappa_n$ の**フィット**で求めていたが、ここでは $\mu$ と $\lambda$ を
$\det L(1+T)$ の係数だけから決めており、フィットしていない（$\nu$ のみ 1 点で決める）。
例 5 の $\lambda=3$ が $\lambda_{\mathrm W}=4$ から出ることが、cycle 12 README §6 の
「$\lambda$ の一般則は今回の対象外」に対する答えになっている。

## 結論

証明本体 §3–§7 の補題 A・B・C・D、定理 1・2・3 は、上記 52 グラフの範囲で 1 件も破れなかった。
とくに定理 1 $(★)$ は、$X_N$ が非連結になる 129 件（cycle 12 README が仮定で除外していたケース）を
含めて $0=0$ の形で成立している。

## 限界（正直に）

- **これらは有限個の例での照合であって、証明ではない。** 証明本体は
  `outputs/reports/cycle13_T3_mu_content_criterion_proof.md` §3–§7 にある。
  本ディレクトリの役割は、証明の書き間違い（符号・添字・場合分けの取りこぼし）の検出に限られる。
- Step 6 の $n_0>0$（乱択 12 塔）は漸近式が $n\ge n_0$ でのみ成立することの現れであり、
  証明の主張と矛盾しない。ただし **$n_0$ の明示的上界は証明本体でも与えていない**（同 §10-7）。
- 検証した $n$ の範囲は有限（$\ell=2$ で $n\le6$、$\ell=3$ で $n\le4$、$\ell=23$ で $n\le1$）。
- 乱択の範囲（頂点 $\le3$、辺 $\le6$、voltage $\in[-3,3]$）の外については何も言えない。
- $\mathbb{Z}_\ell^d$-塔（$d\ge2$）は対象外（証明本体 §10-8）。
