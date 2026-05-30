# 037 T_(V') の psi への作用 — SageMath 検証

## 対象

`parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ` の Claim:

```typst
T_((V'))(psi_mu^dagger) = e^(-gamma(theta_mu)) psi_mu^dagger
T_((V'))(psi_mu) = e^(gamma(theta_mu)) psi_mu
```

## 検証方針

標準的な `M` 個のフェルミオン生成消滅演算子 `c_j^dagger, c_j` の Jordan-Wigner 行列表現を用いる。

```text
psi_mu^dagger := c_[mu]^dagger
psi_mu        := c_[-mu]
```

ここで `[mu]` は `1, ..., M` の代表元で、`0 mod M` は `M` とする。この表現では

```text
[psi_mu^dagger, psi_nu]_+ = delta^M_(mu + nu, 0) I
psi_nu^dagger psi_(-nu) = c_nu^dagger c_nu
```

となる。よって

```text
X = - sum_(nu=1)^M gamma(theta_nu) (psi_nu^dagger psi_(-nu) - 1/2 I)
V' = exp(X)
```

を `2^M x 2^M` 行列として作り、`exp(X) op exp(-X)` を直接計算する。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | `check_01_TVprime_psi_dagger_action.sage` | `T_(V')(psi_mu^dagger) = exp(-gamma(theta_mu)) psi_mu^dagger` | PASS | 最大絶対誤差 `3.28e-16`, 最大相対誤差 `3.28e-16` |
| 02 | `check_02_TVprime_psi_action.sage` | `T_(V')(psi_mu) = exp(gamma(theta_mu)) psi_mu` | PASS | 最大絶対誤差 `2.30e-6`, 最大相対誤差 `2.13e-15` |

## 実行条件

- `M = 2, 4`
- `K1, K2`: `_shared/defs.sage` の `DEFAULT_TEST_PARAMS` 7組
  - `(0.4, 0.8)`
  - `(1.2, 0.3)`
  - `(10.4, 1.8)`
  - `(0.4407, 0.4407)`
  - `(0.2, 0.813)`
  - `(0.05, 0.1)`
  - `(0.3, 5.0)`
- `mu in {-M, ..., -1, 1, ..., M}`
- 許容誤差: 絶対誤差 `1e-9` または相対誤差 `1e-9`

## 実行方法

各ファイルを個別に実行:

```bash
sage sagemath/check/037_claim_T_Vprimeのpsi/check_01_TVprime_psi_dagger_action.sage
sage sagemath/check/037_claim_T_Vprimeのpsi/check_02_TVprime_psi_action.sage
```

全ファイルを一括実行:

```bash
for f in sagemath/check/037_claim_T_Vprimeのpsi/check_*.sage; do echo "=== $f ==="; sage "$f"; done
```

## 実行結果

2026-05-30 に以下を実行し、2件とも `RESULT: PASS` を確認した。

```bash
for f in sagemath/check/037_claim_T_Vprimeのpsi/check_*.sage; do echo "=== $f ==="; sage "$f"; done
```

`psi` 側の最大絶対誤差は極端なパラメータ `K1=10.4, K2=1.8` で大きく出るが、期待値のスケールが大きいため相対誤差は `2.13e-15` に留まる。
