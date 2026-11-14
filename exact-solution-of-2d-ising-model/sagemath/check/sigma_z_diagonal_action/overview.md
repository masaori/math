# SageMath Check: sigma_z_diagonal_action

## 対象

**対象ラベル**: `sigma_z_diagonal_action` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `bridge_002_claim_sigma_z_diagonal_action`（σ_m^z の基底 f_{ι(μ)} への作用）
- 範囲: 主張 `σ_m^z f_{ι(μ)} = μ(m)_C f_{ι(μ)}` と、証明の準備の二つの鎖・場合分けの二つの鎖・固有ベクトルの等式の七行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `σ^z e_1 = … = e_1` の四つの等号と `σ^z e_2 = … = -e_2` の七つの等号 | `check_sigma_z_on_standard_basis.sage` | 鎖の項を順に別の式で作る: Sage の行列の積、`mat_mult` の和を一項ずつ足す経路と手で書いた和、積だけを先に計算した和、手で書いた列、（`e_2` では）第 1 成分の右から足す 0 だけを消した列（加法の単位元）と第 2 成分の左から足す 0 を消した列（`complex_zero_plus_is_original`）、`(-1)·z` の列と成分ごとの符号反転の列、最後に `e_1`・成分ごとの符号反転（`def_matrix_negation`）の `-e_2` | **PASS** | 厳密等号（`ZZ`） |
| 場合分けの二つの鎖（`μ(m) = ±1` のとき `σ^z e_{i_m} = … = μ(m)_C e_{i_m}`） | `check_sigma_z_on_spin_value_cases.sage` | `i_m` を `ι`（`def_config_basis_iso`）で `μ(m)` から作り、各行を別の式で作って比べる。対照として逆の符号では成り立たないこと | **PASS** | 2 場合 |
| 固有ベクトルの等式の六つの等号 | `check_eigenvector_chain.sage` | 鎖の七つの項を別々の式で作る（スクリプトの `line1` は `σ_m^z` と `f_{ι(μ)}` の積、`line4` は因子ごとの積のクロネッカー積、`line6` は第 `m` 因子を `μ(m)e_{i_m}` にしたクロネッカー積、`line7` は `μ(m)` 倍。`line8` は最後の項 `μ(m)_C f_{ι(μ)}`） | **PASS** | `M = 1,…,5`、すべての `μ`・`m` の 258 通り |
| 主張そのもの | `check_statement.sage` | 本文の成分の式で組んだ行列で確かめる。対照として、`-μ(m)` では成り立たないこと、`σ^x` では成り立たないこと | **PASS** | `M = 1,…,5` の 258 通り |

## 計算の帰属と範囲

行列とベクトルの成分はすべて整数なので `ZZ` 上で組み、等号は厳密に判定した。浮動小数点と `RR` / `CC` への脱出はない。
`μ(m)_C = ι_{R→C}(μ(m))` は整数 `±1` のまま係数に使った。包含 `ZZ → CC` は和と積を保つので、`ZZ` で成り立つ等号は本文の複素行列の等号としても成り立つ。

`M ≤ 5` を確かめた。一般の `M` は検算の範囲外で、人手証明が担う。

クロネッカー積は、共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage` で、Sage 組み込みの `tensor_product` と、
本文の定め方（`def_kronecker` の成分の式と番号付け `ν`）で成分から組む経路の両方で作り、二つの一致を確かめてから使う
（`sigma_z_site`・`f_basis`）。`check_eigenvector_chain.sage` の `line1`〜`line3`（鎖の第 1 項から第 3 項）と `line7`〜`line8`（第 6 項と第 7 項）は、定義をそのまま書き直す等号で、
`sigma_z_site`・`f_basis` が `tensor_product` の値を返すので同じ式どうしの比較になる。これらの行の独立な確かめは、
`sigma_z_site`・`f_basis` の中の本文の成分の式との一致が担う。

確かめられない行: `μ(m)` を `ι_{R→C}` で複素数へ送る行の、写像の名前の付け方そのもの（文言の行）と、
`kronecker_multilinear` の数ベクトルの場合を当てはめてよいことの条件（文言の行）。どちらも数値では確かめられない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sigma_z_diagonal_action
```

実行ログは `sagemath/check/sigma_z_diagonal_action/logs/` に保存する。
