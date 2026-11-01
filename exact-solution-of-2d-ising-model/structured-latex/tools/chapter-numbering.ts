/**
 * この論文の章番号の振り出し。HTML（`build-html.ts`）と PDF（`build-latex.ts`）の両方がこの宣言を読むので、
 * 二つの出力の章番号と定理番号が食い違わない。
 * 第 0 章から振る。文書の最初の章（章立て）が第 0 章になる。
 */

import type { ChapterNumbering } from "../../../structured-latex/renderers/chapter-numbering.ts";

export const CHAPTER_NUMBERING: ChapterNumbering = { firstChapterNumber: 0 };
