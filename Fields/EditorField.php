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

use Phact\Form\Fields\TextAreaField;
use Phact\Translate\Translate;

class EditorField extends TextAreaField
{
    public $inputTemplate = 'editor/fields/editor_field_input.tpl';
    
    public function renderInput()
    {
        $lang = 'ru';
        /** @var Translate $translate */
        if ($translate = self::fetchComponent(Translate::class)) {
            $lang = $translate->getLocale();
        }

        return $this->renderTemplate($this->inputTemplate, [
            'rid' => self::generateRandomString(),
            'field' => $this,
            'html' => $this->buildAttributesInput(),
            'id' => $this->getHtmlId(),
            'value' => $this->getRenderValue(),
            'name' => $this->getHtmlName(),
            'lang' => $lang
        ]);
    }

    protected static function generateRandomString($length = 10) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }
}