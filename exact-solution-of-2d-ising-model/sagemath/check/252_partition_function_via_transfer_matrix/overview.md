# SageMath Check: 252_partition_function_via_transfer_matrix

## 対象

**対象ラベル**: `partition_function_via_transfer_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.ts`

- 範囲: Z(J,J′) = tr((V₁V₂)^M)

**完全に独立な 2 経路**。左辺は全 2^{MN} 配位のブルートフォース、右辺は 2^N×2^N の転送行列。(M,N) は 12 マス以下の組み合わせで、**M ≠ N かつ J ≠ J′ の組を含む**（J と J′ が入れ替わっていると検出できるようにするため。実際に入れ替えた転送行列では一致しないことも確認している）。行・列番号と μ の同一視をランダムに置換しても結果が変わらないことも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_bruteforce_vs_trace.sage` | ブルートフォース vs トレース、J/J′ の割り当て、同一視の非依存性 | 82 | 3.378e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-10`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

別セッションが訂正した J と J′ の割り当て（V₁ が J′、V₂ が J）が正しいことを、この check が独立に裏付けている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 252
```

実行ログは `sagemath/check/252_partition_function_via_transfer_matrix/logs/` に保存してある（この表の数値はそのログから取った）。
