# SageMath 検算: 依存の推移閉包の反対称性

## 対象

**対象ラベル**: `claim_reachability_partial_order`

- 併せて検証: `claim_path_time_strictly_increases`、`claim_one_step_subset_reachability`、`claim_reachability_transitive`、`claim_reachability_minimal`、`claim_no_mutual_reachability`、`claim_reachability_irreflexive`
- 検証範囲: 有限関係についての長さ 1 の経路・経路連結・推移閉包の最小性と、CA への接続後の時刻増加・相互到達と自己到達の不存在・反射閉包の部分順序性
- 全数範囲: $|V|\leq2,\ 0\leq\tau\leq3$ の全ての隣接時刻間の関係、および $|V|=3,\ \tau=1$ の全関係。最小性は $|E_\tau|\leq3$ で全ての候補関係も列挙する

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_path_time_increase.sage` | 全依存経路の始点から終点へ時刻が厳密に増える | PASS | 4,900 関係の 53,047 経路で成立 |
| `check_one_step_subset.sage` | 一段依存が長さ 1 の経路として到達可能関係に含まれる | PASS | 4,900 関係の 27,953 辺で成立 |
| `check_path_concatenation_transitivity.sage` | 経路連結と到達可能関係の推移性 | PASS | 4,900 関係の 33,287 経路連結で成立 |
| `check_minimal_transitive_relation.sage` | 到達可能関係が一段依存を含む最小の推移的関係である | PASS | 11 個の一段関係に対する 338 個の推移的上位関係で成立 |
| `check_no_mutual_reachability.sage` | 相互到達と自己到達が存在しない | PASS | 4,900 関係の 48,823 到達対で成立 |
| `check_reflexive_closure_partial_order.sage` | 反射閉包が有限イベント集合上の部分順序である | PASS | 4,900 関係、反射閉包の 86,314 対で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、一般の有限舞台・任意の $\tau\in\mathbb{N}$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 一般の有限関係に対する主張の検算には、その部分族である「隣接時刻間の任意の関係」を用いる。CA 固有の検算も局所規則の内容を仮定せず、一段依存で時刻が 1 増える性質だけを使う。
- 全て有限集合、有限列、非負整数の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/transitive-closure-antisymmetry/check_*.sage; do sage "$file"; done
```
