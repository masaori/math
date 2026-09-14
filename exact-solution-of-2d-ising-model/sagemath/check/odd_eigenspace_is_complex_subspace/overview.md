# SageMath Check: odd_eigenspace_is_complex_subspace

## 対象

**対象ラベル**: `odd_eigenspace_is_complex_subspace` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `F^{(-)}` が零ベクトルを含み、複素数ベクトルの和と複素スカラー倍について閉じること

## チェック一覧

| ファイル | 本文で対応する等式 | ステータス |
|---|---|---|
| `check_zero_action_definition.sage` | `[ε0]_r = Σ_s ε_{rs}0` | **PASS** |
| `check_zero_multiplication.sage` | `Σ_s ε_{rs}0 = Σ_s 0` | **PASS** |
| `check_zero_finite_sum.sage` | `Σ_s 0 = 0` | **PASS** |
| `check_zero_negation.sage` | `0 = -0` | **PASS** |
| `check_add_action_definition.sage` | `[ε(f+g)]_r = Σ_s ε_{rs}(f_s+g_s)` | **PASS** |
| `check_add_distributivity.sage` | 積を各項へ分配する等式 | **PASS** |
| `check_add_split_finite_sum.sage` | 有限和を二つの和へ分ける等式 | **PASS** |
| `check_add_action_reassembly.sage` | 二つの和を `[εf]_r+[εg]_r` へ戻す等式 | **PASS** |
| `check_add_eigenvector_hypotheses.sage` | `εf=-f` と `εg=-g` を使う等式 | **PASS** |
| `check_add_negation.sage` | `-f_r+(-g_r)=-(f_r+g_r)` | **PASS** |
| `check_add_vector_definition.sage` | `-(f_r+g_r)=[-(f+g)]_r` | **PASS** |
| `check_smul_action_definition.sage` | `[ε(af)]_r = Σ_s ε_{rs}(af_s)` | **PASS** |
| `check_smul_associate_left.sage` | `ε_{rs}(af_s)=(ε_{rs}a)f_s` | **PASS** |
| `check_smul_commute_scalar.sage` | `(ε_{rs}a)f_s=(aε_{rs})f_s` | **PASS** |
| `check_smul_associate_right.sage` | `(aε_{rs})f_s=a(ε_{rs}f_s)` | **PASS** |
| `check_smul_extract_finite_sum.sage` | `Σ_s a(ε_{rs}f_s)=aΣ_s ε_{rs}f_s` | **PASS** |
| `check_smul_action_reassembly.sage` | `aΣ_s ε_{rs}f_s=a[εf]_r` | **PASS** |
| `check_smul_eigenvector_hypothesis.sage` | `a[εf]_r=a(-f_r)` | **PASS** |
| `check_smul_negation.sage` | `a(-f_r)=-(af_r)` | **PASS** |
| `check_smul_vector_definition.sage` | `-(af_r)=[-(af)]_r` | **PASS** |

全20等式を、`M=2` の全スピン反転行列と `εf=-f`、`εg=-g` を満たす二つのベクトルに対して
二次体 `QQ(i)` 上の厳密等号として個別に検査した。丸め誤差を伴う数値校正ではなく、
一般の `M` に対する証明は Lean が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh odd_eigenspace_is_complex_subspace
```

実行ログは `sagemath/check/odd_eigenspace_is_complex_subspace/logs/` に保存する。

