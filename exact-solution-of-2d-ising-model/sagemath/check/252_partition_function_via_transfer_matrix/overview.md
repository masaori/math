# SageMath Check: 252_partition_function_via_transfer_matrix

## 対象

**対象ラベル**: `partition_function_via_transfer_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.ts`
  （ブロック `partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`）
- 範囲: `Z(K_1,K_2) = tr((V_1V_2)^{N_row})` と proof の全中間目標
  （(R) 有限和の添字の付け替え・転送行列の積の成分・行列の冪の成分 (*)・トレースの展開・
  指数の積を指数の和へ・`𝔐^{N_row}` と `𝔖` の全単射と (P)・分配関数との一致）
- 記号は本文どおり: 行数 `N_row`（`s(i,j)` の第 1 引数 `i` の周期）、列数 `M_col`（第 2 引数 `j` の周期）、
  `K_1` は同じ行の隣り合うサイト `s(i,j)s(i,j+1)`、`K_2` は隣り合う行の同じ列 `s(i,j)s(i+1,j)` の結合定数。
  `V_1, V_2` の行・列番号は `def_row_configuration_numbering` の `ord` で指す。

**独立な 2 経路**。左辺は全 `2^{N_row M_col}` 配位の和、右辺は `2^{M_col}` 次の転送行列のトレース。
`N_row ≠ M_col` かつ `K_1 ≠ K_2` の組を含め、`K_1` と `K_2` を入れ替えた転送行列では一致しないことも確認する。

## チェック一覧

| ファイル | 検証内容 | 判定数 | 結果 | ステータス |
|---------|---------|-------|------|-----------|
| `check_exact_laurent_identity.sage` | `x_1 = exp(K_1)`, `x_2 = exp(K_2)` を不定元とする `ZZ[x_1^{±1}, x_2^{±1}]` で、`Z` と `tr((V_1V_2)^{N_row})` が多項式として一致。`N_row ≠ M_col` では `x_1 ↔ x_2` の入れ替えが不一致。`(N_row, M_col)` 15 組（`(1,1)` から `(2,6)`, `(6,2)` まで） | 15 組 | 全て一致 | **PASS** |
| `check_proof_steps_exact.sage` | 証明の中間目標を同じ多項式環で一つずつ（`M_col = 1..3`、(*) は `r = 1..3`、トレース以降は `N_row = 1..3`） | — | 全て一致 | **PASS** |
| `check_01_bruteforce_vs_trace.sage` | 倍精度: ブルートフォース vs トレース（`N_row M_col ≤ 12` の 8 組 × `(K_1,K_2)` 4 組）、`K_1/K_2` の割り当て | 50 | 最大相対誤差 3.378e-14 | **PASS** |

## 備考

- **厳密版が主**。`exp(K n) = exp(K)^n`（`n ∈ ZZ`）なので、Laurent 多項式としての一致は任意の
  `K_1, K_2 ∈ ℝ_{>0}` での一致と同値であり、ℝ 脱出を含まない。`Z(1,1) = 2^{N_row M_col}`（配位の総数）も確かめている。
- 倍精度版の許容誤差は相対誤差 `1.0e-10`（成分の最大絶対値で正規化）。一般の `K` の値に `exp` を評価するための
  ℝ 脱出（指数評価）。
- 以前の版にあった「行・列番号と μ の同一視をランダムに置換しても結果が変わらない」判定は削除した。
  本文が番号付けを `ord` に固定し、同一視の取り方を主張しなくなったためである（判定数が 82 から 50 に減ったのはこのため）。
- 転送行列は `_prelude.sage` が「番号 `k` → `μ = ord^{-1}(k)`（2 進展開）」の向きで作る
  （`_shared/row_configurations.sage`）。
- 同じ主張の、パウリ行列表示の転送行列を用いた倍精度での再確認は
  `043_claim_transfer_matrix_bridge/check_04_partition_function.sage`。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 252
```

実行ログは `sagemath/check/252_partition_function_via_transfer_matrix/logs/` に保存してある
（2026-09-26、SageMath 10.9。この表の数値はそのログから取った）。
