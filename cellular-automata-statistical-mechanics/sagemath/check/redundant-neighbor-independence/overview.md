# SageMath 検算: 冗長近傍からの独立性

## 対象

**対象ラベル**: `claim_support_invariance`

- 併せて検証: `claim_no_dependency_on_redundant_element`、`claim_dependency_transfer`
- 検証範囲: 制限写像が追加元の一点反転を消すこと、基準値延長後の制限が元の入力を返すこと、追加元への非依存、元の添字への依存の移送、本質的依存台の集合としての一致
- 全数範囲: $|T|=0,1,2,3$ の全ての部分集合 $S\subseteq T$、全ての局所真理値表 $f:A^S\to A$、必要な全入力

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_restriction_ignores_added_flip.sage` | $w\in T\setminus S$ の一点反転後も $S$ への制限が変わらない | PASS | 114 個の制限等式が一致 |
| `check_base_extension_section.sage` | $\rho^T_S(\iota^T_S(x))=x$ | PASS | 40 個の切断等式が一致 |
| `check_no_dependency_on_added_element.sage` | 冗長拡大は $T\setminus S$ の元に本質的に依存しない | PASS | 92 個の規則・追加元の組で非依存 |
| `check_dependency_transfer.sage` | $S$ の元への本質的依存が拡大前後で一致する | PASS | 920 個の規則・元の組で一致 |
| `check_support_invariance.sage` | $\operatorname{supp}(f\circ\rho^T_S)=\operatorname{supp}(f)$ | PASS | 352 個の規則・包含の組で一致 |

## 限界と帰属

- 全数検査は $|T|\le 3$ に限られ、一般の有限集合に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 全て有限集合と 2 元集合の等号として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/redundant-neighbor-independence/check_*.sage; do sage "$file"; done
```
