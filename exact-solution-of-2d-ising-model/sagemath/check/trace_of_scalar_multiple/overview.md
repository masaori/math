# SageMath Check: trace_of_scalar_multiple

## 対象

**対象ラベル**: `trace_of_scalar_multiple` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_trace_of_scalar_multiple`（行列のスカラー倍のトレースは、トレースのスカラー倍）
- 範囲: 主張と、証明の五行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `tr(αA) = tr(αA+O) = tr(αA+0A) = αtr(A)+0tr(A) = αtr(A)+0 = αtr(A)` | `check_chain.sage` | `α` と `A` の成分を不定元に置き、和・スカラー倍・零行列・トレースを本文の成分の式で組んで隣り合う行を比べる。独立な経路として Sage のスカラー倍と `trace` とも比べる。対照として、`α` を掛けずにトレースを取ると一致しないこと | **PASS** | `n = 1,…,5` で 25 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環（`α` と `A` の成分は不定元）で厳密に確かめた。浮動小数点はない。一般の `n` は人手証明の鎖が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_of_scalar_multiple
```

実行ログは `sagemath/check/trace_of_scalar_multiple/logs/` に保存する（2026-11-03）。
