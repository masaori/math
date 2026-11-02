# SageMath Check: zero_matrix_is_right_zero_of_mat_mult

## 対象

**対象ラベル**: `zero_matrix_is_right_zero_of_mat_mult` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_zero_matrix_is_right_zero_of_mat_mult`（零行列を右から掛けると零行列）
- 範囲: 主張 `A O_{n,p} = O_{m,p}` と、証明の `(i,k)` 成分の五行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の五行 | `check_component_chain.sage` | 鎖の項を各行に書かれた式どおりに組み、隣り合う項が等しい | **PASS** | 27 通りの大きさ、全成分（108 個）で厳密等号 |
| 主張そのもの | 同上 | 本文の積の式で組んだ左辺を零行列と比べ、Sage 組み込みの積（独立な経路）とも比べる。否定コントロールとして、零行列でない右因子では零にならないことも確かめる | **PASS** | 27 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A` の成分（`m, n, p ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。
添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh zero_matrix_is_right_zero_of_mat_mult
```

実行ログは `sagemath/check/zero_matrix_is_right_zero_of_mat_mult/logs/` に保存する（2026-11-02）。
