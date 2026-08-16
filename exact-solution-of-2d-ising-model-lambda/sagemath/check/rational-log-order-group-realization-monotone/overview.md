# SageMath Check: 有理係数の対数順序群の実現写像は順序を保つ

## 対象

**対象ラベル**: `claim_rational_log_order_group_realization_monotone`

- 実行日: 2026-08-17
- 状態: PASS（標本 218 個、順序対 47524 組のうち $\lambda\le_{\Lambda_{\mathbb Q}}\mu$ を満たす 23871 組。286452 検査、約 14 秒。$\lambda\ne\mu$ の全組で区間が分離した）
- 帰属: 可算側の段（共通分母の証人 $N,\lambda_N,\mu_N$、$\operatorname{rat}_\Lambda$ の比較、
  $\Lambda_{\mathbb Q}$ の順序の判定）は `ZZ`/`QQ` の厳密計算。
  実数側の段（$\iota_{\mathbb Q\to\mathbb R}$ の順序保存、実対数の単調性、実現写像の値の比較）は、
  素数の実対数が超越数で厳密には表せないため、**区間演算 `RealBallField(256)`（Arb）**で確かめる。
  区間演算は丸めを区間で包む厳密な包含であり、浮動小数点の丸めをそのまま信じる計算ではない。
  この主張は $\mathbb R$ 脱出を含む（住処 R）ので、README の規則に従い実数側の量にだけ区間演算を使い、
  ここにその理由を記す。区間が重なって判定できない場合は FAIL とする（PASS は「区間が分離して
  不等式が厳密に成り立つ」ことを意味する）。実数体そのものの上の証明は Lean
  （`realizeRational_le_of_rationalLogOrderLE`）が担う。

## 検査内容

`claim_rational_log_order_group_realization_monotone` の証明の各段を、標本 $\lambda,\mu\in\Lambda_{\mathbb Q}$
（台 $\{2,3,5\}$ の係数 6 値の組と、$7$ を含む 2 例）の順序対のうち $\lambda\le_{\Lambda_{\mathbb Q}}\mu$ を
満たすものについて確かめる。

- 証人 $N\ge1$（分母の最小公倍数）、$N\cdot\lambda=\iota(\lambda_N)$、$N\cdot\mu=\iota(\mu_N)$、
  $\lambda_N\le_\Lambda\mu_N$ すなわち $\operatorname{rat}_\Lambda(\lambda_N)\le\operatorname{rat}_\Lambda(\mu_N)$（$\mathbb Q$。厳密）。
- 準備 $0<\iota(N)$、三行目（$\iota$ の順序保存）、四行目（実対数の単調性）を区間演算で。
- 五行目（$\Lambda$ の元の実現は $\operatorname{rat}_\Lambda$ の実対数）と六・七行目（共通分母と有理数倍）は
  等式なので、両辺の包含が重なることを確かめる。
- 結論 $\rho_{\mathbb R}(\lambda)\le\rho_{\mathbb R}(\mu)$。$\lambda\ne\mu$ では区間が分離して厳密に判定できること。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-realization-monotone/check.sage
```
