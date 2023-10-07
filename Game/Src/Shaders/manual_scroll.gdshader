shader_type canvas_item;
uniform float uv_shift : hint_range(0,1)=0;
                                     
void fragment(){                                                        
    vec2 shifteduv = UV;                                                
    shifteduv.x += uv_shift;                                
    vec4 color = texture(TEXTURE, shifteduv);                           
    COLOR = color;
}
