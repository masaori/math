# SageMath Check: epsilon_is_real_symmetric

## 対象

**対象ラベル**: `epsilon_is_real_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`（ブロック `maxeig_claim_epsilon_is_real_symmetric`）
- 範囲: 全スピン反転行列 `ε = σ^x_1⋯σ^x_{M_col}`（`def_global_spin_flip_matrix`）の成分がすべて実数であることと、
  `ε^⊤ = ε` の証明の四行

## チェック一覧

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_kronecker_representation_of_epsilon.sage` | 第一行・最終行が引く表示 `ε = σ^x ⊠ ⋯ ⊠ σ^x`（`epsilon_square_and_eigenvalues` の証明で得た表示）が、定義 `σ^x_1⋯σ^x_M` から作った `ε` と一致すること | **PASS** | `M_col=1,…,6` で厳密等号 |
| `check_entries_are_real.sage` | `σ^x` の成分は 0 か 1、クロネッカー積の成分は各因子の成分の積（`def_kronecker` (1)）なので `ε` の成分はすべて実数（0 か 1） | **PASS** | `M_col=1,…,6` の全成分で厳密一致 |
| `check_transpose_of_kronecker_product.sage` | 第二行 `(σ^x ⊠ ⋯)^⊤ = (σ^x)^⊤ ⊠ ⋯`（`kronecker_transpose`） | **PASS** | `M_col=1,…,6` で厳密等号 |
| `check_sigma_x_is_symmetric.sage` | 第三行 `(σ^x)^⊤ ⊠ ⋯ = σ^x ⊠ ⋯`（`(σ^x)^⊤ = σ^x` を各因子へ） | **PASS** | `M_col=1,…,6` で厳密等号 |
| `check_epsilon_transpose_equals_epsilon.sage` | 主張全体 `ε^⊤ = ε` と、定義から作った `ε` の転置から出発して四行の鎖の隣り合う値が等しいこと | **PASS** | `M_col=1,…,6` で厳密等号 |

全成分を `QQ` に置き、`QQ ⊂ ℝ ⊂ ℂ` の包含の前に等号を厳密に判定した。浮動小数点と ℝ/ℂ への脱出はない。
検査範囲は `M_col = 1,…,6` の有限例であり、一般の `M_col` の証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_is_real_symmetric
```

各ファイルは同じディレクトリの `_prelude.sage` を相対名で読むので、このディレクトリで実行する。
実行ログは `sagemath/check/epsilon_is_real_symmetric/logs/` に保存してある（2026-09-26、SageMath 10.9）。
