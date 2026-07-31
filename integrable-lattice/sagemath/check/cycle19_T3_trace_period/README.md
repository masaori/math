# cycle 19 / step 3（T3 Pure）: $\pi_{\mathrm{tr}}(p,k)$ の閉形式・$w^*$ の代数的記述・予想 A の決着

## 対象

整数行列 $T\in M_d(\mathbb{Z})$ と素数 $p\nmid\det T$ に対する、トレース列
$(\operatorname{Tr}T^N\bmod p^k)_N$ の周期 $t_k=\pi_{\mathrm{tr}}(p,k)$。

cycle 18 step 2（`sagemath/check/cycle18_T3_trace_period/`）が確定させた上界
$t_k\mid p^{k-1}t_{w^*+1}$ の**先**を検証する。すなわち

1. cycle 18 が**未証明の予想 A**として残した階段 $k\ge w^*+1\Rightarrow t_{k+1}\mid p\,t_k$
   （本 step で**証明した**）。
2. そこから出る**改良した上界** $t_k\mid p^{\max(k-w^*-1,0)}t_{w^*+1}$。
3. $w^*$ の**代数的閉形式**（トレース双対と微分。$\eta=(\chi'/(\chi/\rho))(\theta)$）。
4. $t_k$ の閉じた公式が**存在しないこと**の反例。

証明本体: [`outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md`](../../../outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md)

対象ラベル（論文本文のブロック）は [`overview.md`](overview.md) に宣言する。

## 手順

```
sage trace_period_closed_form.sage      # 出力: trace_period_closed_form.out
```

外部依存は SageMath 10.6 のみ。乱数は `set_random_seed` で固定してあり再現する。
標本は cycle 18 step 2 と同じ生成則・同じ seed（random 385 組 + degenerate-enriched 506 組）に、
スカラー族 36 組（閉形式の反例が現れる族）を足したもの。

## 結論

- **証明済みの主張（W1, W2, W3, Y1, Y2, Y4, Y5, Y6）は 927 組・のべ 25,000 件超の検査で反例 0。**
- **偽であるべき主張（Y3, Y7, Y8）はいずれも反例が出た**（検査系が反例を検出できることの確認）。
- 詳細な件数は [`overview.md`](overview.md)、生ログは `trace_period_closed_form.out`。
