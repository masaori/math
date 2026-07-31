# cycle 18 / T3 Pure: トレース列の周期 $\pi_{\mathrm{tr}}(p,k)$ の上界の数値検証

**対象・手順・結論の詳細は [`overview.md`](overview.md) に書いてある**（対象ラベル一覧・
実行結果・失敗件数・統計的規律）。本ファイルは検証ディレクトリの規約に沿った要約である。

## 対象

$T\in M_d(\mathbb{Z})$、素数 $p\nmid\det T$ に対するトレース列 $(\operatorname{Tr}T^N\bmod p^k)_N$ の
最小周期 $\pi_{\mathrm{tr}}(p,k)$ の上界。証明本体は
[`outputs/reports/cycle18_T3_trace_period_bound.md`](../../../outputs/reports/cycle18_T3_trace_period_bound.md)、
論文側の対象ラベルは `paper_prop_C_trace`（命題 C′）。

## 手順

```
sage trace_period_bounds.sage        # 出力: trace_period_bounds.out（約 10 分）
```

SageMath 10.6 のみに依存。乱数は seed 固定で、2 回実行して同一出力を確認済み。

## 結論

- 主結果 $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$ を含む**証明済みの主張 10 種は
  891 組・延べ 5 万件超の検査で失敗 0 件**。
- 素朴な主張（$\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,1)$ 等）は期待どおり反例が出た
  （3.9% / 1.6% / 10.9%）。検査系が反例を検出できることの確認になっている。
- 未証明の予想（$w^*+1\le k\le2w^*$ での階段）は 402 件で反例 0 だが、**数値支持どまり**と明記する
  （検出力の見積もりは `overview.md`）。
