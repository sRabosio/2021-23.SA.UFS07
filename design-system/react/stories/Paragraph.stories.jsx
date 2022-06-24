import React from 'react';

import { Paragraph } from '../src/molecules/paragraph/paragraph';
import { Text } from '../src/atoms/text/text';

export default{
    title: 'Example/Molecules/Paragraph',
    Component: Paragraph,

    argTypes: {

    },
};

const Template = (args) => <Paragraph {...args}> </Paragraph>;

export const plainParagraph = Template.bind({});
plainParagraph.args = {
    children: <Text label={'label'}></Text>,
};

