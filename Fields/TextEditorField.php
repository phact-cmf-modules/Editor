<?php
/**
 *
 *
 * All rights reserved.
 *
 * @author Okulov Anton
 * @email qantus@mail.ru
 * @version 1.0
 * @date 14/11/16 12:52
 */

namespace Modules\Editor\Fields;

use Phact\Orm\Fields\TextField;

class TextEditorField extends TextField
{
    public function getFormField()
    {
        return $this->setUpFormField([
            'class' => EditorField::class
        ]);
    }
}